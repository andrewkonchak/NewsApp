//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Andrew on 3/16/18.
//  Copyright © 2018 Andrew Konchak. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

//    var model: [NewsModel]? = []
    var api = NewsApi()
    
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.fetchArticles()
        api.tableController = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.api.newsModel.count 
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        
        cell.title.text = self.api.newsModel[indexPath.item].newsTitle
        cell.descript.text = self.api.newsModel[indexPath.item].newsDescription
        cell.date.text = self.api.newsModel[indexPath.item].newsDate
        cell.source.text = self.api.newsModel[indexPath.item].newsSource.name
//        cell.ImageView.downloadImage(from: (self.api.newsModel[indexPath.item].imageUrl)!)
        
        return cell
    }

}
