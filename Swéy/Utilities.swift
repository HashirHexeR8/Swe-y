//
//  Utilities.swift
//  Swey
//
//  Created by Muhammad Hashir Rafique on 21/10/2024.
//

import Foundation

struct Utilities {
    
    static func formatDateToDBFormat(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // To handle the 'Z' for UTC
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: date)
    }
}
