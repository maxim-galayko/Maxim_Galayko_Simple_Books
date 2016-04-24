//
//  GenreEntity.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim on 4/22/16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import Foundation
import CoreData


class GenreEntity: NSManagedObject {
    
    func fillWithGenre(genre: GenresModel) {
        displayName = genre.displayName
        encodedName = genre.encodedName
    }
}
