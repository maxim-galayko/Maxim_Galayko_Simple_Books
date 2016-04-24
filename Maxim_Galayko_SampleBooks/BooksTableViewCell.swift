//
//  BooksTableViewCell.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim Galayko on 4/23/16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import UIKit

class BooksTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "BooksTableViewCellStoryboardIdentifier"

    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var bookNameLabel: UILabel!
    @IBOutlet var authorNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func clear() {
        coverImageView.image = nil
        bookNameLabel.text = nil
        authorNameLabel.text = nil
    }
}

extension BooksTableViewCell {
    func fillWithBook(book: BooksModel, imageProvider: BestSellersImageProviderProtocol) {
        bookNameLabel.text = book.title
        authorNameLabel.text = book.author
        imageProvider.fetchImage(book) { image in
            self.coverImageView.image = image
        }
    }
}
