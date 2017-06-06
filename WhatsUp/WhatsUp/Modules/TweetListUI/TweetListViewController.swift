//
//  TweetListUI.swift
//  WhatsUp
//
//  Created by Ankur Kesharwani on 05/31/2017.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit
import CoreData
import PersistenceStore
import Theme
import Logic

class TweetListViewController: UIViewController,
    TweetListUI,
    UserDialogUIPresenter,
    LoadingUIPresenter,
    FRCManagerDelegate,
    TweetTableViewCellDelegate,
    UITableViewDelegate,
    UITableViewDataSource,
    UISearchBarDelegate {

    // MARK: Static/Class Methods

    static func newInstance() -> TweetListUI! {
        return TweetListViewController.init(nibName: "TweetListViewController", bundle: nil)
    }

    // MARK: IBOutlets
    
    @IBOutlet var tvTableView: UITableView!
    @IBOutlet var vMoreContentLoadingView: UIView!

    // MARK: Properties
    
    var twitterSearchManager: TwitterSearchManager!
    var frcManager: FRCManager?
    var rcRefreshControl: UIRefreshControl?
    var loadingUI: LoadingUI!
    var sbSearchBar: UISearchBar!
    
    var fetchingTweets: Bool = false

    // MARK: Constants

    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupNavigationBar()
        setupTableView()
        setupRefreshControl()
        
        setupFetchResultsControllerManager()
        reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchTweets()
    }

    // MARK: Public Methods

    func dismissUI() {
        // TODO: Provide own implementation
    }
    
    func fetchTweets() {
        let searchString = sbSearchBar.text!
        guard searchString.characters.count > 0 else {
            hideLoader()
            rcRefreshControl?.endRefreshing()
            
            return
        }

        if hasTweetsLocally() == false {
            showLoader(message: "Fetching Tweets")
        }
        
        fetchingTweets = true
        twitterSearchManager.fetchTweetsForSearchString(searchString)
    }
    
    func fetchTweetsForSearchString(_ searchString: String) {
        showLoader(message: "Lets see what the world thinks about \(searchString)")
        fetchingTweets = true
        twitterSearchManager.fetchTweetsForSearchString(searchString)
    }
    
    func showDetailsForUser(_ user: CDUser) {
        let params = UserDialogUIInitParams(user: user)
        let ui = initUserDialogUI(initParams: params)
        presentUserDialogUI(ui!)
    }
    
    func gotoAuthenticationUI() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.goToAuthenticationUI()
    }

    // MARK: Open Access Methods

    // MARK: Private Methods
    
    private func setupNavigationBar() {
        sbSearchBar = UISearchBar()
        sbSearchBar.tintColor = Theme.Color.muddyRed
        sbSearchBar.placeholder = "Search"
        sbSearchBar.showsCancelButton = true
        sbSearchBar.delegate = self
        navigationItem.titleView = sbSearchBar
    }
    
    private func setupTableView() {
        TweetTableViewCell.registerCellForTableView(tableView: tvTableView)
        
        tvTableView.dataSource = self
        tvTableView.delegate = self
        
        tvTableView.estimatedRowHeight = 100.0
        tvTableView.rowHeight = UITableViewAutomaticDimension
        
        tvTableView.contentInset = UIEdgeInsetsMake(4, 0, 4, 0)
    }
    
    private func setupRefreshControl() {
        rcRefreshControl = UIRefreshControl()
        rcRefreshControl?.addTarget(self, action: #selector(self.fetchTweets), for: .valueChanged)
        
        tvTableView.addSubview(rcRefreshControl!)
    }
    
    private func setupFetchResultsControllerManager() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Tweet")
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "strID", ascending: false)]
        
        frcManager = FRCManager.init(request: fetchRequest, context: twitterSearchManager.context)
        frcManager?.delegate = self
        
        frcManager?.performfetch()
    }

    fileprivate func reloadData() {
        handleNoData()
        
        tvTableView.reloadData()
    }
    
    fileprivate func handleNoData() {
        if hasTweetsLocally() {
            if getFooterView() != nil {
                removeFooterView()
                
                return
            }
        } else {
            if getFooterView() == nil {
                let noDataView = TweetListNoDataEmptyView.newInstance()
                noDataView.set(title: "No Tweets", subTitle: "Seems like nothing is happening!", buttonTitle: "RETRY")
                
                setFooterView(view: noDataView)
            }
        }
    }
    
    fileprivate func handleNoInternet() {
        if hasTweetsLocally() {
            let alertController = UIAlertController.init(title: "Opps!", message: "No internet connection!", preferredStyle: .alert)
            
            let okAction = UIAlertAction.init(title: "Ok", style: .default)
            
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            
            // Hide current empty view if any.
            removeFooterView()
            
            // Create new empty view.
            let errorView = TweetListNoInternetErrorView.newInstance()
            errorView.set(title: "No Internet",
                          subTitle: "Seems like you either have no access to internet or very poor connection. Please try again later ",
                          buttonTitle: "RETRY")
            
            // Show.
            setFooterView(view: errorView)
        }
    }
    
    fileprivate func handleAPIError(message: String) {
        if hasTweetsLocally() {
            let alertController = UIAlertController.init(title: "Opps!", message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction.init(title: "Ok", style: .default)
            
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        } else {
            
            // Hide current empty view if any.
            removeFooterView()
            
            // Create new empty view.
            let errorView = TweetListAPIErrorView.newInstance()
            errorView.set(title: "Opps!",
                          subTitle: message,
                          buttonTitle: "RETRY")
            
            // Show.
            setFooterView(view: errorView)
        }
    }
    
    fileprivate func setFooterView(view: UIView) {
        tvTableView.tableFooterView = view
    }
    
    fileprivate func removeFooterView() {
        tvTableView.tableFooterView = nil
    }
    
    fileprivate func showLoader(message: String) {
        let params = LoadingUIInitParams(title: message, style: .light)
        loadingUI = initLoadingUI(initParams: params)
        
        presentLoadingUI(loadingUI: loadingUI, in: view)
    }
    
    fileprivate func hideLoader() {
        guard loadingUI != nil else {
            return
        }
        
        dismissLoadingUI(loadingUI: loadingUI)
    }
    
    fileprivate func hasTweetsLocally() -> Bool {
        return (frcManager?.fetchResultsController.fetchedObjects?.count ?? 0) > 0
    }
    
    fileprivate func getFooterView() -> UIView? {
        return tvTableView.tableFooterView
    }
    
    fileprivate func handleLinksForTweet(_ tweet: CDTweet) {
        guard tweet.hasLinks() else {
            return
        }
        
        if let links = tweet.links?.allObjects as? [CDLink] {
            let alertCtrl = UIAlertController.init(title: "Open in Safari", message: nil, preferredStyle: .actionSheet)
            for link in links {
                let action = UIAlertAction.init(title: link.stringURL, style: .default, handler: { (action) in
                    UIApplication.shared.openURL(URL(string: link.stringURL!)!)
                })
                
                alertCtrl.addAction(action)
            }
            
            let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil)
            alertCtrl.addAction(cancelAction)
            
            present(alertCtrl, animated: true, completion: nil)
        }
    }
    
    // MARK: IBActions
    
    // MARK: UITableViewDataSource and UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return frcManager?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frcManager?.numberOfRows(inSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.kIdentifier, for: indexPath) as! TweetTableViewCell
        
        cell.delegate = self
        
        cell.configureWithObject(object: frcManager!.objectAtIndexPath(indexPath: indexPath), forIndexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tweet = frcManager?.objectAtIndexPath(indexPath: indexPath) as! CDTweet
        
        handleLinksForTweet(tweet)
    }
    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let acctualPosition = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height - tvTableView.frame.size.height
        if acctualPosition >= contentHeight && twitterSearchManager.hasNext() && fetchingTweets == false && hasTweetsLocally() {
            twitterSearchManager.fetchNextTweetsSet()
            
            setFooterView(view: vMoreContentLoadingView)
        }
    }
    
    // MARK: TweetTableViewCellDelegate
    
    func tweetTableViewCell(_ cell: TweetTableViewCell, didSelectUser user: CDUser) {
        showDetailsForUser(user)
    }
    
    // MARK:  TwitterSearchManagerDelegate
    
    public func twitterSearchManager(_ manager: TwitterSearchManager, fetchedTweets tweets: [CDTweet]?) {
        hideLoader()
        rcRefreshControl?.endRefreshing()
        
        fetchingTweets = false
    }
    
    public func twitterSearchManager(_ manager: TwitterSearchManager, searchFailedWithError error: Error?) {
        
        // Dismiss loading
        hideLoader()
        rcRefreshControl?.endRefreshing()
        
        fetchingTweets = false
        
        // Handle error cases
        if error is TwitterSearchManagerError {
            handleAPIError(message: "Could not fetch tweets at this moment. Please try again later")
        } else {
            handleNoInternet()
        }
    }
    
    public func authenticationExpired(manager: TwitterSearchManager) {
        
        // Dismiss loading
        hideLoader()
        rcRefreshControl?.endRefreshing()
        
        fetchingTweets = false
        
        gotoAuthenticationUI()
    }
    
    // MARK: UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        sbSearchBar.resignFirstResponder()
        
        if let searchString = searchBar.text {
            fetchTweetsForSearchString(searchString)
        }
    }
    
    func searchBarCancelButtonClicked(_: UISearchBar) {
        sbSearchBar.resignFirstResponder()
    }
    
    // MARK: FRCManagerDelegate
    
    func fetchResultsUpdated(manager: FRCManager) {
        handleNoData()
        
        tvTableView.beginUpdates()
        tvTableView.deleteSections(IndexSet(manager.updateResult.deletedSectionIndices), with: .fade)
        tvTableView.insertSections(IndexSet(manager.updateResult.insertedSectionIndices), with: .fade)
        tvTableView.deleteRows(at: manager.updateResult.deletedRowIndexPaths, with: .fade)
        tvTableView.insertRows(at: manager.updateResult.insertedRowIndexPaths, with: .fade)
        
        // This is how we handle update cases.
        for updateIndexPath in manager.updateResult.updatedRowIndexPaths {
            if let cell = tvTableView.cellForRow(at: updateIndexPath) {
                let tweet = manager.objectAtIndexPath(indexPath: updateIndexPath) as! CDTweet
                (cell as! TweetTableViewCell).configureWithObject(object: tweet, forIndexPath: updateIndexPath)
            }
        }
        
        tvTableView.endUpdates()
        
        manager.updateResult.clearAll()
    }
}
