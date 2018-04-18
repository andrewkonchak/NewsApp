//
//  CategoryTabBarController.swift
//  NewsApp
//
//  Created by Andrew on 4/15/18.
//  Copyright © 2018 Andrew Konchak. All rights reserved.
//

import UIKit

class CategoryTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var controllersList: [UIViewController] = []
        
        for category in NewsCategory.allCategories {
            if let navController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "navController") as? UINavigationController,
                let newsController = navController.viewControllers.first as? NewsTableViewController {
                let item = UITabBarItem(title: category.rawValue, image: category.tabBarImg, tag: category.tabBarTag)
                newsController.category = category
                newsController.tabBarItem = item
                controllersList.append(newsController)
            }
        }
        setViewControllers(controllersList, animated: true)
    }
}
