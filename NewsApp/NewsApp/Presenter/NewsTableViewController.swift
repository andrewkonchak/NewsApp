//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Andrew on 3/16/18.
//  Copyright © 2018 Andrew Konchak. All rights reserved.
//

import UIKit
import SafariServices

class NewsTableViewController: UITableViewController, UISearchBarDelegate {
    
    var api = NewsApi()
    var newsArray = [NewsModel]()

    // MARK: - Refresh control
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        refreshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        
        return refreshControl
    }()
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet weak var newsLabelCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.fetchArticles(country: NewsCountry.ukraine, category: NewsCategory.business)
        api.tableController = self
        
        newsLabelCount.layer.cornerRadius = 11
        newsLabelCount.layer.borderWidth = 1
        newsLabelCount.layer.borderColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        newsLabelCount.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        tableview.refreshControl = refresher
        
        searchController()
     
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
    
    // MARK: - Search Bar delegate
   
    func searchController() {
        
        let searchBar = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchBar
        navigationItem.hidesSearchBarWhenScrolling = true
        UISearchBar.appearance().tintColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
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
        cell.author.text = self.api.newsModel[indexPath.row].newsAuthor
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
