//
//  DataRequest.swift
//  SocialFeed
//
//  Created by Luis Alejandro Ramirez on 11/26/19.
//  Copyright © 2019 Luis Alejandro Ramirez. All rights reserved.
//

import Foundation

struct DataRequest {
    static func loadData(page: Int, completion: @escaping (([Post]) -> Void)) {
        let jsonDecoder = JSONDecoder()
        
        loadDataFromNetwork(page: page) { posts in
            guard let networkPosts = posts else {
                var posts = [Post()]
                guard let path = Bundle.main.path(forResource: "\(page)", ofType: "json"),
                    let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
                    let postsDecoded = try? jsonDecoder.decode([Post].self, from: data) else {
                        completion(posts)
                        return
                }
                posts = postsDecoded
                completion(posts)
                return
            }
            completion(networkPosts)
        }
    }
    
    static func loadDataFromNetwork(page: Int, completion: @escaping (([Post]?) -> Void)) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "storage.googleapis.com"
        components.path = "/cdn-og-test-api/test-task/social/\(page).json"
        let jsonDecoder = JSONDecoder()
        
        guard let url = components.url,
            let timeoutInterval = TimeInterval(exactly: 300) else {
            preconditionFailure("Failed to construct URL")
        }
        let taskConfiguration = URLSessionConfiguration.default
        taskConfiguration.timeoutIntervalForRequest = timeoutInterval
        
        let urlSession = URLSession(configuration: taskConfiguration)
        let task = urlSession.dataTask(with: url) {
            data, response, error in
            
            DispatchQueue.main.async {
                if let data = data {
                    let postsDecoded = try? jsonDecoder.decode([Post].self, from: data)
                    completion(postsDecoded)
                } else {
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
}
