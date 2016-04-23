//
//  BooksModel.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim on 4/22/16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import UIKit

class BooksModel {
    var title: String!
    var author: String!
    var imageLink: String!
    var rank: Int!
    var amazonLink: String!
    
    init?(json: [String: AnyObject]) {
        guard let title = json["title"] as? String, author = json["author"] as? String, imageLink = json["book_image"] as? String,
            rank = json["rank"] as? Int, amazonLink = json["amazon_product_url"] as? String else {
                return nil
        }
        self.title = title
        self.author = author
        self.imageLink = imageLink
        self.rank = rank
        self.amazonLink = amazonLink
    }
}
