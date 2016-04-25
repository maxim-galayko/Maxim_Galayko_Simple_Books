//
//  GenresTableViewCell.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim on 4/25/16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import UIKit

class GenresTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "GenresTableViewCellStoryboardIdentifier"
    
    @IBOutlet var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
