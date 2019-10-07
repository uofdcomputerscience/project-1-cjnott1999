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
    
    func getImage(url: URL, completion: @escaping ((UIImage) -> Void)) {
        // download the image, and call the completion with the url and image.
        // the cell can then verify that the image being returned is the one
        // requested.
        // you may even keep a dictionary of results, and then call the completion
        // with an entry from that dictionary, if one exists, otherwise make the
        // network call and store its result in the dictionary as well as calling
        // the completion. This would allow the _second_ call for any image to not
        // perform a network operation!

        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
                  completion(cachedImage)

        }
        
        else{
            let session = URLSession(configuration: .ephemeral)
            let task = session.dataTask(with: url){
                (data, response, error) in
                
                if  let data = data {
                    let image = UIImage(data: data)
                    self.imageCache.setObject(image!, forKey: url.absoluteString as NSString)
                    completion(image!)
       
                }
            }
            task.resume()
        }

        
        
    }
    

}

