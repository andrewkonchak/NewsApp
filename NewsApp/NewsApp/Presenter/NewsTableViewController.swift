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
    
    var api = NewsApi()
    var filteredNews = [NewsModel]()
    var category: NewsCategory = .general
    var country: NewsCountry = .ukraine
    
    // MARK: - Search control
    lazy var searchBar: UISearchController = {
        return UISearchController(searchResultsController: nil)
    }()
    
    // MARK: - Refresh control
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        refreshControl.addTarget(self, action: #selector(requestData), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        api.fetchArticles(country: country, category: category)
        api.tableController = self
        
        tableview.refreshControl = refresher
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
        
        navigationController?.navigationItem.searchController = searchBar
        navigationItem.hidesSearchBarWhenScrolling = true
        
        UISearchBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        searchBar.searchResultsUpdater = self
        
        self.searchBar.dimsBackgroundDuringPresentation = false
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
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
        return api.newsModel.isEmpty ? 0 : 1
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
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let newsUrl = searchBar.isActive ? filteredNews[indexPath.row].url : api.newsModel[indexPath.row].url
        if let url = URL(string: newsUrl) {
            let webVC = SFSafariViewController(url: url)
            if presentedViewController != nil {
                presentedViewController?.present(webVC, animated: true, completion: nil)
            } else {
                present(webVC, animated: true, completion: nil)
            }
        }
    }
}

extension NewsTableViewController: UIPopoverPresentationControllerDelegate {
   
    @IBAction func changeCountryButton(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "pop", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pop" {
            if let dest = segue.destination as? CountryViewController {
                dest.delegate = self
                if let pop = dest.popoverPresentationController {
                    pop.delegate = self
                }
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension NewsTableViewController: CountryViewControllerDelegate {
    
    func didSelectCountry(_ country: NewsCountry) {
        self.country = country
        api.fetchArticles(country: country, category: category)
    }
    
}

