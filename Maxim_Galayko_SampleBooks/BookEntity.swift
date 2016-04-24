//
//  BookEntity.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim on 4/22/16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import Foundation
import CoreData


class BookEntity: NSManagedObject {

    func fillWithBook(book: BooksModel) {
        amazonLink = book.amazonLink
        author = book.author
        imageLink = book.imageLink
        rank = book.rank
        title = book.title
    }

}
