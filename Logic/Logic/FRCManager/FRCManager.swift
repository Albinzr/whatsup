//
//  FRCManager.swift
//  Logic
//
//  Created by Ankur Kesharwani on 11/05/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import Foundation
import CoreData


public class FRCManagerUpdateResult {
    public var deletedSectionIndices: [Int]!
    public var insertedSectionIndices: [Int]!
    public var deletedRowIndexPaths: [IndexPath]!
    public var insertedRowIndexPaths: [IndexPath]!
    public var updatedRowIndexPaths: [IndexPath]!

    init() {
        deletedSectionIndices = [Int]()
        insertedSectionIndices = [Int]()
        deletedRowIndexPaths = [IndexPath]()
        insertedRowIndexPaths = [IndexPath]()
        updatedRowIndexPaths = [IndexPath]()
    }

    public func clearAll() {
        deletedSectionIndices.removeAll()
        insertedSectionIndices.removeAll()
        deletedRowIndexPaths.removeAll()
        insertedRowIndexPaths.removeAll()
        updatedRowIndexPaths.removeAll()
    }
}


public protocol FRCManagerDelegate: class {
    func fetchResultsUpdated(manager: FRCManager)
}

public class FRCManager: NSObject, NSFetchedResultsControllerDelegate {
    public var updateResult: FRCManagerUpdateResult!
    public var fetchResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    public weak var delegate: FRCManagerDelegate?
    
    public var context: NSManagedObjectContext {
        return fetchResultsController.managedObjectContext
    }
    
    // MARK: Lifecycle methods
    
    public convenience init(request: NSFetchRequest<NSFetchRequestResult>, context: NSManagedObjectContext) {
        self.init()
        
        updateResult = FRCManagerUpdateResult()
        fetchResultsController = NSFetchedResultsController.init(fetchRequest: request,
                                                                 managedObjectContext: context,
                                                                 sectionNameKeyPath: nil,
                                                                 cacheName: nil)
        
        fetchResultsController.delegate = self
    }
    
    deinit {
        updateResult = nil
        fetchResultsController.delegate = nil
        delegate = nil
    }
    
    // MARK: Public methods
    
    public func performfetch() {
        do {
            try fetchResultsController.performFetch()
        } catch {
            print(error)
        }
    }
    
    public  func numberOfSections() -> Int? {
        return fetchResultsController.sections?.count
    }
    
    public func numberOfRows(inSection sectionIndex: Int) -> Int? {
        return fetchResultsController.sections?[sectionIndex].numberOfObjects
    }
    
    public func objectAtIndexPath(indexPath: IndexPath) -> NSManagedObject! {
        return fetchResultsController.object(at: indexPath) as! NSManagedObject
    }
    
    // MARK: FRC delegate methods
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .insert {
            if updateResult.insertedSectionIndices.contains(newIndexPath!.section) {
                // If we've already been told that we're adding a section for this inserted row we skip it since it will handled by the section insertion.
                return
            }
            
            updateResult.insertedRowIndexPaths.append(newIndexPath!)
        } else if type == .delete {
            if updateResult.deletedSectionIndices.contains(indexPath!.section) {
                // If we've already been told that we're deleting a section for this deleted row we skip it since it will handled by the section deletion.
                
                return
            }
            
            updateResult.deletedRowIndexPaths.append(indexPath!)
        } else if type == .move {
            if updateResult.insertedSectionIndices.contains(newIndexPath!.section) == false {
                updateResult.insertedRowIndexPaths.append(newIndexPath!)
            }
            
            if updateResult.deletedSectionIndices.contains(indexPath!.section) == false {
                updateResult.deletedRowIndexPaths.append(indexPath!)
            }
        } else if type == .update {
            updateResult.updatedRowIndexPaths.append(newIndexPath!)
        }
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        if type == .insert {
            updateResult.insertedSectionIndices.append(sectionIndex)
        } else if type == .delete {
            updateResult.deletedSectionIndices.append(sectionIndex)
        }
    }
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.fetchResultsUpdated(manager: self)
    }
}
