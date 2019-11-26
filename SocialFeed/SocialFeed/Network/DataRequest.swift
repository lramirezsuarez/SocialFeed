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
        var posts = [Post()]
        let jsonDecoder = JSONDecoder()
        
        guard let path = Bundle.main.path(forResource: "\(page)", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
            let postsDecoded = try? jsonDecoder.decode([Post].self, from: data) else {
                completion(posts)
                return
        }
        posts = postsDecoded
        completion(posts)
    }
}
