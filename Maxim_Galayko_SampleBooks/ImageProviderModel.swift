//
//  ImageProviderModel.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim Galayko on 4/24/16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import UIKit

protocol ImageProviderProtocol {
    func fetchImage(link: String, completion: (image: UIImage?) -> Void)
}

protocol BestSellersImageProviderProtocol: ImageProviderProtocol {
    func fetchImage(book: BooksModel, completion: (image: UIImage?) -> Void)
}

class OnlineImageProvider: BestSellersImageProviderProtocol {
    private var cache = NSCache()
    
    func fetchImage(book: BooksModel, completion: (image: UIImage?) -> Void) {
        fetchImage(book.imageLink, completion: completion)
    }
    
    func fetchImage(link: String, completion: (image: UIImage?) -> Void) {
        if let image = cache[link] {
            completion(image: image as? UIImage)
            return
        }
        if let url = NSURL(string: link) {
            UIImage.loadFromURL(url) { image in
                self.cache[link] = image
                completion(image: image)
            }
        } else {
            completion(image: nil)
        }
    }
}


class OfflineImageProvider: BestSellersImageProviderProtocol {
    func fetchImage(book: BooksModel, completion: (image: UIImage?) -> Void) {
        fetchImage(book.imageLink, completion: completion)
    }
    
    func fetchImage(link: String, completion: (image: UIImage?) -> Void) {
        
    }
}