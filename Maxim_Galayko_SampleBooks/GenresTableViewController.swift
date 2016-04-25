//
//  GenresTableViewController.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim on 4/22/16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import UIKit

class GenresTableViewController: UITableViewController {
    
    private var bestSellersModel = BestSellersDataSourceProvider.dataSourceModel()
    private var dataSource: [GenresModel] = []
    
    private let bestSellersSegueIdentifier = "GenresToBestSellersStoryboardSegueIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Genres"
        fetchGenres()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func fetchGenres() {
        bestSellersModel.genres { genres in
            if let genres = genres {
                self.dataSource = genres
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(GenresTableViewCell.reuseIdentifier, forIndexPath: indexPath) as! GenresTableViewCell
        cell.accessoryType = .DisclosureIndicator

        cell.titleLabel.text = dataSource[indexPath.row].displayName
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(bestSellersSegueIdentifier, sender: self)
    }
    
    // MARK: - Segue
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let bestSellersController = segue.destinationViewController as? BestSellersTableViewController {
            bestSellersController.bestSellersModel = bestSellersModel
            bestSellersController.genre = dataSource[tableView.indexPathForSelectedRow!.row]
        }
    }

}
