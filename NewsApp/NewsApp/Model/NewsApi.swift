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
                        if let title = articleFromJson["title"] as? String,
                            let source = articleFromJson["source"] as? [String : AnyObject],
                            let author = source["name"] as? String,
                            let descrip = articleFromJson["description"] as? String,
                            let url = articleFromJson["url"] as? String,
                            let urlToImage = articleFromJson["urlToImage"] as? String,
                            let dateNews = articleFromJson["publishedAt"] as? String {
                            
                            mainNews.newsSource.name = author
                            mainNews.newsDescription = descrip
                            mainNews.newsTitle = title
                            mainNews.url = url
                            mainNews.imageUrl = urlToImage
                            mainNews.newsDate = dateNews
                            
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

extension UIImageView {
    
    func downloadImage(from url: String){
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        
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

