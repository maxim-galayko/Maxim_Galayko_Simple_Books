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
    
    private let genresReuseIdentifier = "GenresReuseIdentifier"
    private let bestSellersSegueIdentifier = "GenresToBestSellersStoryboardSegueIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        fetchGenres()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func fetchGenres() {
        bestSellersModel.genres { genres in
            if let genres = genres {
                self.dataSource = genres
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    private func prepareTableView() {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: genresReuseIdentifier)
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(genresReuseIdentifier, forIndexPath: indexPath)
        cell.accessoryType = .DisclosureIndicator

        cell.textLabel?.text = dataSource[indexPath.row].displayName
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
