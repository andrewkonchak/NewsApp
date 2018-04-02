//
//  NewsApi.swift
//  NewsApp
//
//  Created by Andrew on 3/23/18.
//  Copyright © 2018 Andrew Konchak. All rights reserved.
//

import Foundation
import UIKit

class NewsApi {
    
    var newsModel = [NewsModel]()
    var tableController: NewsTableViewController?
    
    // MARK: - Parsing JSON
    
    func fetchArticles(){
        let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=9a209a9a266f47838f0c32ff4202b97c")!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            
            if error != nil {
                print(error)
                return
            }
            
            self.newsModel = [NewsModel]()
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let articlesFromJson = json["articles"] as? [[String : AnyObject]] {
                    for articleFromJson in articlesFromJson {
                        let mainNews = NewsModel()
                        if  let title = articleFromJson["title"] as? String,
                            let source = articleFromJson["source"] as? [String : AnyObject],
                            let author = source["name"] as? String,
                            let descrip = articleFromJson["description"] as? String,
                            let url = articleFromJson["url"] as? String,
                            let urlToImage = articleFromJson["urlToImage"] as? String,
                            let dateNews = articleFromJson["publishedAt"] as? String {
                            
//                            let newsCounter = articleFromJson["totalResults"] as? Int
                            
                            mainNews.newsSource.name = author
                            mainNews.newsDescription = descrip
                            mainNews.newsTitle = title
                            mainNews.url = url
                            mainNews.imageUrl = urlToImage
                            mainNews.newsDate = dateNews
//                            mainNews.newsCount = String(newsCounter)
                            
                        }
                        self.newsModel.append(mainNews)
                    }
                }
                DispatchQueue.main.async {
                    self.tableController?.tableview.reloadData()
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
}

// MARK: - Download image from url

extension UIImageView {
    
    func downloadImage(from url: String){
        
        if let url = URL(string: url) {
            let urlRequest = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
                
                if error != nil {
                    print(error)
                    return
                }
                DispatchQueue.main.async {
                    self.image = UIImage(data: data!)
                }
            }
            task.resume()
        }
    }
}
