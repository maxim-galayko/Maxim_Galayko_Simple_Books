//
//  DataSourceModel.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim on 4/22/16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import UIKit

protocol BestSellersDataSourceModelProtocol {
    func genres(completion: (genres: [GenresModel]?) -> Void)
    func booksWithGenre(genre: GenresModel, completion: (books: [BooksModel]?) -> Void)
}

class BestSellersDataSourceModel: BestSellersDataSourceModelProtocol {
    private var genres: [GenresModel]?
    private var books: [String: [BooksModel]] = [:]
    private let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    
    func genres(completion: (genres: [GenresModel]?) -> Void) {
        if let _ = genres {
            completion(genres: genres)
            return
        }
        fetchGenres(completion)
    }
    
    func booksWithGenre(genre: GenresModel, completion: (books: [BooksModel]?) -> Void) {
        if let books = books[genre.encodedName] {
            completion(books: books)
            return
        }
        fetchBooks(genre, completion: completion)
    }
    
    // MARK: - Private
    
    private func fetchGenres(completion: (genres: [GenresModel]?) -> Void) {
        let url = NSURL(string: Links.bestSellersGenres)!
        session.dataTaskWithURL(url) { data, response, error in
            if let data = data, let jsonGenres = try? NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)["results"] as? [[String: AnyObject]] {
                var parsedGenres: [GenresModel] = []
                for jsonGenre in jsonGenres! {
                    if let genre = GenresModel(json: jsonGenre) {
                        parsedGenres.append(genre)
                    }
                }
                if parsedGenres.isEmpty == false {
                    self.genres = parsedGenres
                }
            }
            completion(genres: self.genres)
        }.resume()
    }
    
    private func fetchBooks(genre: GenresModel, completion: (books: [BooksModel]?) -> Void) {
        let link = String(format: Links.bestSellersList, genre.encodedName)
        let url = NSURL(string: link)!
        session.dataTaskWithURL(url) { data, response, error in
            if let data = data, let jsonBooks = try? NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)["results"]??["books"] as? [[String: AnyObject]] {
                var parsedBooks: [BooksModel] = []
                for jsonBook in jsonBooks! {
                    if let book = BooksModel(json: jsonBook) {
                        parsedBooks.append(book)
                    }
                }
                if parsedBooks.isEmpty == false {
                    self.books[genre.encodedName] = parsedBooks
                }
            }
            completion(books: self.books[genre.encodedName])
        }.resume()
    }
}

class CachedBestSellersDataSourceModel: BestSellersDataSourceModelProtocol {
    func genres(completion: (genres: [GenresModel]?) -> Void) {
        
    }
    func booksWithGenre(genre: GenresModel, completion: (books: [BooksModel]?) -> Void) {
        
    }
}