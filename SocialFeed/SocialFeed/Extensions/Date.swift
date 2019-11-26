//
//  Date.swift
//  SocialFeed
//
//  Created by Luis Alejandro Ramirez on 11/26/19.
//  Copyright © 2019 Luis Alejandro Ramirez. All rights reserved.
//

import Foundation

extension Date {
    func toString(_ format: DateFormat) -> String {
        let dateFormatter = DateFormatter.cached(withFormat: format)
        dateFormatter.calendar = Calendar.currentUtc
        dateFormatter.timeZone = TimeZone.utc
        return dateFormatter.string(from: self)
    }
}
