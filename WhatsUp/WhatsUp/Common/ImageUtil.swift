//
//  ImageUtil.swift
//  WhatsUp
//
//  Created by Ankur Kesharwani on 05/06/17.
//  Copyright © 2017 Ankur Kesharwani. All rights reserved.
//

import UIKit
import Services

class ImageUtil {
    
    class func setAsyncImage(fromURLString URLString: String?,
                              placeholderImage: UIImage?,
                              to imageView: UIImageView?,
                              useTag tag: Int?,
                              placeholderFillColor fillColor: UIColor?) {
        
        if placeholderImage != nil {
            imageView?.image = placeholderImage
        } else {
            imageView?.image = nil
        }
        
        if fillColor != nil {
            imageView?.backgroundColor = fillColor
        } else {
            imageView?.backgroundColor = .clear
        }
        
        guard URLString != nil else {
            return
        }
        
        if tag != nil {
            imageView?.tag = tag!
        }
        
        let tagToUseForCheck = imageView?.tag
        
        ImageService.fetchImage(fromURLString: URLString!, successCallback: { (response) in
            if response.statusCode == 200 {
                if let image = response.response as? UIImage {
                    if imageView?.tag == tagToUseForCheck {
                        imageView?.image = image
                    }
                }
            }
        }) { (error) in
            print(error)
        }
    }
}
