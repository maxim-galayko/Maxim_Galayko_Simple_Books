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
    
    private var imageProvider = BestSellersDataSourceProvider.imageProvider()
    private var dataSource: [BooksModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
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
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(BooksTableViewCell.reuseIdentifier, forIndexPath: indexPath) as! BooksTableViewCell
        cell.clear()
        let book = dataSource[indexPath.row]
        cell.fillWithBook(book, imageProvider: imageProvider)

        return cell
    }


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let bookDetailsController = segue.destinationViewController as? BookDetailsViewController {
            let book = dataSource[tableView.indexPathForSelectedRow!.row]
            bookDetailsController.book = book
            bookDetailsController.genre = genre
            bookDetailsController.imageProvider = imageProvider
        }
    }
}
