//
//  Calendar+UTC.swift
//  SocialFeed
//
//  Created by Luis Alejandro Ramirez on 11/26/19.
//  Copyright © 2019 Luis Alejandro Ramirez. All rights reserved.
//

import Foundation

extension Calendar {
    static var currentUtc: Calendar {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.utc ?? TimeZone.current
        return calendar
    }
}
