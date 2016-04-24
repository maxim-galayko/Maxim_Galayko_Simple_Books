//
//  BookDetailsViewController.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim Galayko on 4/23/16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import UIKit
import FBSDKShareKit

class BookDetailsViewController: UIViewController {

    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var bookNameLabel: UILabel!
    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var bookRankLabel: UILabel!
    @IBOutlet var amazonLinkLabel: UILabel!
    
    var genre: GenresModel!
    var book: BooksModel!
    var imageProvider: BestSellersImageProviderProtocol!
    
    private let savingService = BestSellersSavingService()

    override func viewDidLoad() {
        super.viewDidLoad()
        fillBookInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func fillBookInfo() {
        imageProvider.fetchImage(book) { image in
            self.coverImageView.image = image
        }
        bookNameLabel.text = book.title
        authorNameLabel.text = book.author
        bookRankLabel.text = String(book.rank)
        amazonLinkLabel.text = book.amazonLink
    }
    
    // MARK: - Actions
    
    @IBAction func cacheBook(sender: AnyObject) {
        imageProvider.fetchImage(book) { image in
            self.savingService.saveBook(self.book, withImage: image, forGenre: self.genre)
        }
    }
    
    @IBAction func shareBook(sender: AnyObject) {
        let shareBookContent = FBSDKShareLinkContent()
        shareBookContent.contentTitle = book.title
        shareBookContent.contentURL = NSURL(string: book.amazonLink)!
        shareBookContent.imageURL = NSURL(string: book.imageLink)!

        FBSDKShareDialog.showFromViewController(self.parentViewController, withContent: shareBookContent, delegate: nil)
    }
}
