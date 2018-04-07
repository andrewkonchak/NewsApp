//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Andrew on 3/16/18.
//  Copyright © 2018 Andrew Konchak. All rights reserved.
//

import UIKit
import SafariServices

class NewsTableViewController: UITableViewController {
    
    var api = NewsApi()
    
    // MARK: - Refresh control
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = #colorLiteral(red: 0.7792011499, green: 0.3920885921, blue: 0.1603198946, alpha: 1)
        refreshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        
        return refreshControl
    }()
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet weak var newsLabelCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.fetchArticles()
        api.tableController = self
        
        newsLabelCount.layer.cornerRadius = 11
        newsLabelCount.layer.borderWidth = 1
        newsLabelCount.layer.borderColor = #colorLiteral(red: 0.7792011499, green: 0.3920885921, blue: 0.1603198946, alpha: 1)
        
        tableview.refreshControl = refresher
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Refresh control time end refreshing
    @objc
    func requestData() {
        
        let timeRefresh = DispatchTime.now() + .milliseconds(1000)
        DispatchQueue.main.asyncAfter(deadline: timeRefresh) {
            self.refresher.endRefreshing()
        }
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
        
        self.newsLabelCount.text = String(self.api.newsModel.count)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsUrl = self.api.newsModel[indexPath.row].url
        let URL = NSURL(string: newsUrl)!
        let webVC = SFSafariViewController(url: URL as URL)
        
        present(webVC, animated: true, completion: nil)
        
    }
}


