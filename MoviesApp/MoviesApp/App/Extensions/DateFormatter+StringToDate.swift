//
//  DateFormatter+StringToDate.swift
//  MoviesApp
//
//  Created by Javier Heisecke on 2024-08-15.
//

import Foundation

extension DateFormatter {
    
    func stringToDate_yyyyMMdd(_ value: String?) -> Date? {
        guard let value else { return nil }
        locale = Locale(identifier: "en_US_POSIX")
        dateFormat = "yyyy-MM-dd"
        return date(from: value)
    }
}
