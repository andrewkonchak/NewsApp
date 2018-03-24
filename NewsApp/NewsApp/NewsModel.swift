//
//  NewsModel.swift
//  NewsApp
//
//  Created by Andrew on 3/16/18.
//  Copyright © 2018 Andrew Konchak. All rights reserved.
//

import UIKit

class NewsModel: NSObject {
    
    var newsTitle: String?
    var newsDescription: String?
    var newsSource = NewsSource()
    var newsDate: String?
    var url: String?
    var imageUrl: String?
    var totalResults: Int?

}
