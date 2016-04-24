//
//  GenresModel.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim on 4/22/16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import UIKit

class GenresModel {
    var displayName: String!
    var encodedName: String!
    
    init?(json: [String: AnyObject]) {
        guard let displayName = json["display_name"] as? String, encodedName = json["list_name_encoded"] as? String else {
            return nil
        }
        self.displayName = displayName
        self.encodedName = encodedName
    }
    
    init?(entity: GenreEntity) {
        guard let displayName = entity.displayName, encodedName = entity.encodedName else {
            return
        }
        self.displayName = displayName
        self.encodedName = encodedName
    }
}