//
//  Extensions.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim Galayko on 4/23/16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import UIKit
import FBSDKLoginKit

extension UIImage {
    class func loadFromURL(url: NSURL, completion: (UIImage?) -> Void) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0)) {
            var image: UIImage?
            if let imageData = NSData(contentsOfURL: url) {
                image = UIImage(data: imageData)
            }
            dispatch_async(dispatch_get_main_queue()) {
                completion(image)
            }
        }
    }
}


extension NSCache {
    subscript(key: AnyObject) -> AnyObject? {
        get {
            return objectForKey(key)
        }
        set {
            if let value: AnyObject = newValue {
                setObject(value, forKey: key)
            } else {
                removeObjectForKey(key)
            }
        }
    }
}

extension FBSDKAccessToken {
    class func authorized() -> Bool {
        return FBSDKAccessToken.currentAccessToken() != nil
    }
}