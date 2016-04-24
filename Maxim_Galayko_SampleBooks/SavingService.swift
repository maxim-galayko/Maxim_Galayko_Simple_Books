//
//  SavingProvider.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim Galayko on 4/24/16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import UIKit
import CoreData

protocol BestSellersSavingServiceProtocol {
    func saveBook(book: BooksModel, withImage image: UIImage?, forGenre genre: GenresModel)
    func removeAll()
}

class BestSellersSavingService: BestSellersSavingServiceProtocol {
    private var manager = CoreDataManagerProvider.sharedManager
    
    func saveBook(book: BooksModel, withImage image: UIImage?, forGenre genre: GenresModel) {
        saveBook(book, forGenre: genre)
        if let image = image {
            saveImage(image, forBook: book)
        }
    }
    
    func removeAll() {
        removeAllFromEntity("BookEntity")
        removeAllFromEntity("GenreEntity")
        removeSavedImages()
    }
    
    // MARK: - Private
    
    private func removeAllFromEntity(entityName: String) {
        let entitiesRequest = NSFetchRequest(entityName: entityName)
        if let entities = try? manager.managedObjectContext.executeFetchRequest(entitiesRequest) as? [NSManagedObject] {
            for entity in entities! {
                manager.managedObjectContext.deleteObject(entity)
            }
            manager.saveContextChanges()
        }
    }
    
    private func removeSavedImages() {
    }
    
    private func saveBook(book: BooksModel, forGenre genre: GenresModel) {
        let bookEntityInfo = prepareUniqueEntityWithBook(book)
        if bookEntityInfo.justCreated {
            let genreEntityInfo = prepareUniqueEntityWithGenre(genre)
            bookEntityInfo.entity.genre = genreEntityInfo.entity
            manager.saveContextChanges()
        }
    }
    
    private func prepareUniqueEntityWithGenre(genre: GenresModel) -> (entity: GenreEntity, justCreated: Bool) {
        let fetchRequest = NSFetchRequest(entityName: "GenreEntity")
        fetchRequest.predicate = NSPredicate(format: "encodedName == %@", genre.encodedName)
        if let genres = try? manager.managedObjectContext.executeFetchRequest(fetchRequest) as? [GenreEntity] where genres!.count > 0 {
            return (genres!.first!, false)
        } else {
            let entityDescription = NSEntityDescription.entityForName("GenreEntity", inManagedObjectContext: manager.managedObjectContext)
            let entity = GenreEntity(entity: entityDescription!, insertIntoManagedObjectContext: manager.managedObjectContext)
            entity.fillWithGenre(genre)
            return (entity, true)
        }
    }
    
    private func prepareUniqueEntityWithBook(book: BooksModel) -> (entity: BookEntity, justCreated: Bool) {
        let fetchRequest = NSFetchRequest(entityName: "BookEntity")
        fetchRequest.predicate = NSPredicate(format: "amazonLink == %@", book.amazonLink)
        if let books = try? manager.managedObjectContext.executeFetchRequest(fetchRequest) as? [BookEntity] where books!.count > 0 {
            return (books!.first!, false)
        } else {
            let entityDescription = NSEntityDescription.entityForName("BookEntity", inManagedObjectContext: manager.managedObjectContext)
            let entity = BookEntity(entity: entityDescription!, insertIntoManagedObjectContext: manager.managedObjectContext)
            entity.fillWithBook(book)
            return (entity, true)
        }
    }
    
    private func saveImage(image: UIImage, forBook book: BooksModel) {
    
    }
}