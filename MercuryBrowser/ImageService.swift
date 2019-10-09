//
//  ImageService.swift
//  MercuryBrowser
//
//  Created by Cameron Nottingham on 10/6/19.
//  Copyright © 2019 Russell Mirabelli. All rights reserved.
//

import UIKit

struct ImageService{
    
    let imageCache = NSCache<NSString, UIImage>()
    
    //get image based on URL, either from cache or the internet
    func getImage(url: URL, completion: @escaping ((UIImage, URL) -> Void)) {
        //If the image already exists, use the cached version
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
                  completion(cachedImage, url)

        }
        
        //If not, we need to get it from the network
        else{
            let session = URLSession(configuration: .ephemeral)
            let task = session.dataTask(with: url){
                (data, response, error) in
                
                if  let data = data {
                    let image = UIImage(data: data)
                    self.imageCache.setObject(image!, forKey: url.absoluteString as NSString)
                    completion(image!, url)
       
                }
            }
            task.resume()
        }

        
        
    }
    

}

