//
//  BookEntity+CoreDataProperties.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim Galayko on 4/24/16.
//  Copyright © 2016 Maxim. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension BookEntity {

    @NSManaged var amazonLink: String?
    @NSManaged var author: String?
    @NSManaged var imageLink: String?
    @NSManaged var imagePath: String?
    @NSManaged var rank: NSNumber?
    @NSManaged var title: String?
    @NSManaged var genre: GenreEntity?

}
