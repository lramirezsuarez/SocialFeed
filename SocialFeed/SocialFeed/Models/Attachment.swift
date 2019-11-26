//
//  Attachment.swift
//  SocialFeed
//
//  Created by Luis Alejandro Ramirez on 11/26/19.
//  Copyright © 2019 Luis Alejandro Ramirez. All rights reserved.
//

import Foundation

struct Attachment: Codable {
    var height, width: Int?
    var pictureLink: String?

    enum CodingKeys: String, CodingKey {
        case height, width
        case pictureLink = "picture-link"
    }
}
