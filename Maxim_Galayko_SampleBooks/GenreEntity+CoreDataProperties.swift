//
//  GenreEntity+CoreDataProperties.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim Galayko on 4/22/16.
//  Copyright © 2016 Maxim. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension GenreEntity {

    @NSManaged var displayName: String?
    @NSManaged var encodedName: String?
    @NSManaged var books: NSSet?

}
