//
//  Post.swift
//  SocialFeed
//
//  Created by Luis Alejandro Ramirez on 11/26/19.
//  Copyright © 2019 Luis Alejandro Ramirez. All rights reserved.
//

import Foundation

struct Post: Codable {
    var author: Author?
    var date: String?
    var link: String?
    var network: NetworkType?
    var text: Text?
    var attachment: Attachment?
}

enum NetworkType: String, Codable {
    case twitter
    case facebook
    case instagram
    case unknown
}
