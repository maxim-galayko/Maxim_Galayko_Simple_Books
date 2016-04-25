//
//  BestSellersTableViewController.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim Galayko on 4/23/16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import UIKit

class BestSellersTableViewController: UITableViewController {
    
    var bestSellersModel: BestSellersDataSourceModelProtocol!
    var genre: GenresModel!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var imageProvider = BestSellersDataSourceProvider.imageProvider()
    private var dataSource: [BooksModel] = []
    private var filteredDataSource: [BooksModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Best Sellers"
        prepareTableView()
        fetchBooks()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func fetchBooks() {
        bestSellersModel.booksWithGenre(genre) { books in
            if let books = books {
                self.dataSource = books
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    
    private func prepareTableView() {
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableHeaderView = searchController.searchBar
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredDataSource.count
        }
        return dataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(BooksTableViewCell.reuseIdentifier, forIndexPath: indexPath) as! BooksTableViewCell
        cell.clear()
        let book: BooksModel
        if searchController.active && searchController.searchBar.text != "" {
            book = filteredDataSource[indexPath.row]
        } else {
            book = dataSource[indexPath.row]
        }
        cell.fillWithBook(book, imageProvider: imageProvider)

        return cell
    }
    
    // MARK: - Search bar
    
    func filterContentForSearchText(searchText: String) {
        filteredDataSource = dataSource.filter { book in
            return book.title.lowercaseString.containsString(searchText.lowercaseString) || book.author.lowercaseString.containsString(searchText.lowercaseString)
        }
        tableView.reloadData()
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let bookDetailsController = segue.destinationViewController as? BookDetailsViewController {
            let book: BooksModel
            if let indexPath = tableView.indexPathForSelectedRow {
                if searchController.active && searchController.searchBar.text != "" {
                    book = filteredDataSource[indexPath.row]
                } else {
                    book = dataSource[indexPath.row]
                }
                bookDetailsController.book = book
            }
            bookDetailsController.genre = genre
            bookDetailsController.imageProvider = imageProvider
        }
    }
}

extension BestSellersTableViewController: UISearchResultsUpdating {

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
