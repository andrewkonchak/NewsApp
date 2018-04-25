//
//  File.swift
//  NewsApp
//
//  Created by Andrew on 4/10/18.
//  Copyright © 2018 Andrew Konchak. All rights reserved.
//

import UIKit

public enum NewsCategory: String {
    
    case business = "business"
    case politics = "politics"
    case sport = "sport"
    case technology = "technology"
    case general = "general"
    
    static let allCategories: [NewsCategory] = [.general, .business, .politics, .sport, .technology]
    
    var tabBarTag: Int {
        switch self {
        case .general:
            return 0
        case .business:
            return 1
        case .politics:
            return 2
        case .sport:
            return 3
        case .technology:
            return 4
        }
    }
    
    var tabBarImg: UIImage {
        switch self {
        case .general:
            return #imageLiteral(resourceName: "all")
        case .business:
            return #imageLiteral(resourceName: "business")
        case .politics:
            return #imageLiteral(resourceName: "politics")
        case .sport:
            return #imageLiteral(resourceName: "sport")
        case .technology:
            return #imageLiteral(resourceName: "technology")
        }
    }
}

public enum NewsCountry: String {
    case australia = "au"
    case germany = "de"
    case unitedKingdom = "gb"
    case india = "in"
    case italy = "it"
    case unitedStates = "us"
    case russia = "ru"
    case ukraine = "ua"
    case france = "fr"
}

