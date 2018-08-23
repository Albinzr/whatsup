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
        
        let imageRequest = GetImageRequest()
        imageRequest.urlString = URLString!
        imageRequest.execute { (response) in
            if response.error != nil {
                print(response.error!)
                
                return
            }
            
            if let image = response.image {
                if imageView?.tag == tagToUseForCheck {
                    imageView?.image = image
                }
            }
        }
    }
}
