//
//  Author.swift
//  SocialFeed
//
//  Created by Luis Alejandro Ramirez on 11/26/19.
//  Copyright © 2019 Luis Alejandro Ramirez. All rights reserved.
//

import Foundation

struct Author: Codable {
    var account: String?
    var isVerified: Bool?
    var name: String?
    var pictureLink: String?

    enum CodingKeys: String, CodingKey {
        case account
        case isVerified = "is-verified"
        case name
        case pictureLink = "picture-link"
    }
}
