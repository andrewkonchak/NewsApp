//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Andrew on 3/16/18.
//  Copyright © 2018 Andrew Konchak. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

    var api = NewsApi()
    
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.fetchArticles()
        api.tableController = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.api.newsModel.count 
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        
        cell.title.text = self.api.newsModel[indexPath.row].newsTitle
        cell.descript.text = self.api.newsModel[indexPath.row].newsDescription
        cell.date.text = self.api.newsModel[indexPath.row].newsDate
        cell.source.text = self.api.newsModel[indexPath.row].newsSource.name
        cell.ImageView.downloadImage(from: (self.api.newsModel[indexPath.row].imageUrl))
        
        return cell
    }

}
