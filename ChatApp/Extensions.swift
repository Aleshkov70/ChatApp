//
//  Extensions.swift
//  ChatApp
//
//  Created by Aleshkov Andrei on 04.04.17.
//  Copyright © 2017 andrei. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString: String) {
        
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url! as? URL)!, completionHandler: {(data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async( execute: {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    
                    self.image = downloadedImage
                    
                }
            })
            
        }).resume()
    }
    
}
