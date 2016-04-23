//
//  Links.swift
//  Maxim_Galayko_SampleBooks
//
//  Created by Maxim on 4/22/16.
//  Copyright © 2016 Maxim. All rights reserved.
//

import UIKit

private let apiBasePath = "http://api.nytimes.com/svc/books/v3/lists"
private let apiBooksKey = "925bece9843e242dea32cb93c7743f0f:11:75072226"

class Links: NSObject {
    static let bestSellersGenres = "\(apiBasePath)/names?api-key=\(apiBooksKey)"
    static let bestSellersList = "\(apiBasePath)/%@?api-key=\(apiBooksKey)"
}