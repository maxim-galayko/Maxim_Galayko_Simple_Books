//
//  BookDetailsViewController.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim Galayko on 4/23/16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {

    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var bookNameLabel: UILabel!
    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var bookRankLabel: UILabel!
    @IBOutlet var amazonLinkLabel: UILabel!
    
    var book: BooksModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        fillBookInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func fillBookInfo() {
        
    }
    
    // MARK: - Actions
    
    @IBAction func cacheBook(sender: AnyObject) {
        
    }
    
    @IBAction func shareBook(sender: AnyObject) {
        
    }
}
