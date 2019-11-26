//
//  DateFormatter+Cached.swift
//  SocialFeed
//
//  Created by Luis Alejandro Ramirez on 11/26/19.
//  Copyright © 2019 Luis Alejandro Ramirez. All rights reserved.
//

import Foundation

private var cachedFormatters = [DateFormat: DateFormatter]()

extension DateFormatter {
    
    static func getFormatter(_ format: DateFormat) -> DateFormatter {
        let formatter = DateFormatter.cached(withFormat: format)
        formatter.timeZone = TimeZone.utc
        return formatter
    }
}

extension DateFormatter {
    
    static let dateFormatterLocaleSuffix = "_POSIX"
    
    /// To use it, just call DateFormatter.cached(withFormat: "<date format>")
    /// - parameters:
    /// - format: String representing the date time format, for example: dd/mm/yyyy
    static func cached(withFormat format: DateFormat) -> DateFormatter {
        if let cachedFormatter = cachedFormatters[format] {
            return cachedFormatter
        }
        let formatter = DateFormatter()
        let localeIdentifier: String = Locale.preferredLanguages.first ?? Locale.current.identifier
        formatter.locale = Locale(identifier: localeIdentifier + DateFormatter.dateFormatterLocaleSuffix)
        formatter.dateFormat = format.rawValue
        cachedFormatters[format] = formatter
        return formatter
    }
    
    /// Returns the Cached Formatters Count
    ///
    /// - Returns: The number of Cached Formatters
    static func cachedFormattersCount() -> Int {
        return cachedFormatters.count
    }
    
    /// Removes all cached Formatters
    static func clearCachedFormatters() {
        cachedFormatters.removeAll()
    }
}
