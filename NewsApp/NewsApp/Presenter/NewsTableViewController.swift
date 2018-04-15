//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Andrew on 3/16/18.
//  Copyright © 2018 Andrew Konchak. All rights reserved.
//

import UIKit
import SafariServices

class NewsTableViewController: UITableViewController, UISearchResultsUpdating {

    let searchBar = UISearchController(searchResultsController: nil)
    let tabBarCnt = UITabBarController()
    
    var api = NewsApi()
    var filteredNews = [NewsModel]()

    // MARK: - Refresh control
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        refreshControl.addTarget(self, action: #selector(requestData), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    @IBOutlet var tableview: UITableView!
    @IBOutlet weak var newsLabelCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.fetchArticles(country: NewsCountry.unitedStates, category: NewsCategory.scienceAndNature)
        api.tableController = self
        
        newsLabelCount.layer.cornerRadius = 11
        newsLabelCount.layer.borderWidth = 1
        newsLabelCount.layer.borderColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        newsLabelCount.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        tableview.refreshControl = refresher
        
        searchController()
        createTabBarController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Refresh control time end refreshing
   
    @objc
    func requestData() {
        let timeRefresh = DispatchTime.now() + .milliseconds(1000)
        DispatchQueue.main.asyncAfter(deadline: timeRefresh) {
            self.tableview.reloadData()
            self.refresher.endRefreshing()
        }
    }
    
    // MARK: - Search Controller
   
    func searchController() {
        navigationItem.searchController = searchBar
        navigationItem.hidesSearchBarWhenScrolling = true
        UISearchBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        searchBar.searchResultsUpdater = self
        self.searchBar.dimsBackgroundDuringPresentation = false
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
    }
    
    // MARK: - Custom TabBarController
    
    func createTabBarController() {
    
        tabBarCnt.tabBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tabBarCnt.tabBar.barStyle = .black
        
        let AllVC = UIViewController()
        AllVC.tabBarItem = UITabBarItem.init(title: "All", image: UIImage(named: "all"), tag: 0)

        
        let sportVC = UIViewController()
        sportVC.tabBarItem = UITabBarItem.init(title: "Sport", image: UIImage(named: "sport"), tag: 1)
        
        let businessVC = UIViewController()
        businessVC.tabBarItem = UITabBarItem.init(title: "Business", image: UIImage(named: "business"), tag: 2)
        
        tabBarCnt.viewControllers = [AllVC, sportVC, businessVC]
        self.view.addSubview(tabBarCnt.view)
    }
    
    
    //MARK: - UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text! == "" {
            filteredNews = api.newsModel
        } else {
            // Filter the results
            filteredNews = api.newsModel.filter {
                $0.newsTitle.lowercased().contains(searchController.searchBar.text!.lowercased())
            }
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBar.isActive {
            return filteredNews.count
        }
        return self.api.newsModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell
        
        let newsData: NewsModel
        newsData = searchBar.isActive ? filteredNews[indexPath.row] : api.newsModel[indexPath.row]
        
        cell.title.text = newsData.newsTitle
        cell.descript.text = newsData.newsDescription
        cell.author.text = newsData.newsAuthor
        cell.source.text = newsData.newsSource.name
        cell.ImageView.downloadImage(from: (newsData.imageUrl))
        
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

