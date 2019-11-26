//
//  Date+ISO8601.swift
//  SocialFeed
//
//  Created by Luis Alejandro Ramirez on 11/26/19.
//  Copyright © 2019 Luis Alejandro Ramirez. All rights reserved.
//

import Foundation

extension ISO8601DateFormatter {
    convenience init(_ formatOptions: Options, timeZone: TimeZone = TimeZone(secondsFromGMT: 0)!) {
        self.init()
        self.formatOptions = formatOptions
        self.timeZone = timeZone
    }
}

extension Formatter {
    @available(iOS 11.0, *)
    static let iso8601 = ISO8601DateFormatter([.withInternetDateTime, .withFractionalSeconds])
}

extension Date {
    @available(iOS 11.0, *)
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}

extension String {
    @available(iOS 11.0, *)
    var iso8601: Date? {
        return Formatter.iso8601.date(from: self)
    }
}
