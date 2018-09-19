//
//  Date.swift
//  Mextension
//
//  Created by Vitor Mesquita on 18/09/2018.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import Foundation

// MARK: - Convert to string
public extension Date {

    /**
     Tranform just date (year/month/day) in string
     */
    var simpleDate: String {
        return stringBy(format: "yyyy-MM-dd")
    }

    /**
     Tranform date and time in string
     */
    var fullDate: String {
        return stringBy(format: "yyyy-MM-dd HH:mm:ss")
    }

    /**
     Tranform date in a displayable string
     */
    var simpleDisplayDate: String {
        return stringBy(format: "dd/MM/yyyy")
    }

    /**
     Convert a date to string with especific format
     - See Also [NSDateFormatter](http://nsdateformatter.com/)
     - parameter format: String date format

     */
    func stringBy(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

// MARK: - Convert string to date
public extension Date {

    /**
     Convert string to optional date
     - parameter string: Date string
     */
    public static func dateFrom(string: String?) -> Date? {
        guard let stringValue = string else { return nil }

        let parseFormat = DateFormatter()

        let dateFormat =  ["yyyy-MM-dd",
                           "yyyy-MM-dd'T'HH:mm:ss",
                           "yyyy-MM-ddTHH:mm:ss",
                           "yyyy-MM-dd'T'HH:mm:ss",
                           "yyyy-MM-dd'T'HH:mm:ssZZ",
                           "yyyy-MM-dd'T'HH:mm:ssZZZ",
                           "yyyy-MM-dd'T'HH:mm:ss.SSS",
                           "yyyy-MM-dd'T'HH:mm:ss.SSSZZZ",
                           "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZ",
                           "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZZZ",
                           "yyyy-MM-dd HH:mm:ss",
                           "HH:mm:ss",
                           "HH:mm"]

        let dates = dateFormat.compactMap { format -> Date? in
            parseFormat.dateFormat = format
            parseFormat.timeZone = TimeZone.current
            return parseFormat.date(from: stringValue)
        }
        return dates.first
    }
}
