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
    Transform date in a week day date (ex: thursday)
    */
   var weekDay: String {
      let myCalendar = Calendar(identifier: .gregorian)
      let weekDay = myCalendar.component(.weekday, from: self)
      return DateFormatter().weekdaySymbols[weekDay]
   }
   
   /**
    Relative date from today (ex: Tomorrow, Yesterday)
    */
   var relativeDate: String {
      let dateFormatter = DateFormatter()
      dateFormatter.dateStyle = .short
      dateFormatter.doesRelativeDateFormatting = true
      return dateFormatter.string(from: self)
   }
   
   /**
    Convert a date to string with especific format
    - See Also [NSDateFormatter](http://nsdateformatter.com/)
    - parameter format: String date format
    - parameter timeZone: TimeZone to set the correct timestemp if needed
    - parameter locale: Locale to set the correct locale if needed
    */
   func stringBy(format: String, timeZone: TimeZone = .current, locale: Locale = .current) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.locale = locale
      dateFormatter.dateFormat = format
      dateFormatter.timeZone = timeZone
      return dateFormatter.string(from: self)
   }
   
   /**
    Get time from date and convert it to string
    - parameter style: Time style to show as string
    - parameter timeZone: TimeZone to set the correct timestemp if needed
    */
   func time(style: DateFormatter.Style, timeZone: TimeZone = TimeZone.current) -> String {
      let dateFormatter = DateFormatter()
      dateFormatter.timeStyle = style
      dateFormatter.dateStyle = .none
      dateFormatter.timeZone = timeZone
      return dateFormatter.string(from: self)
   }
}

// MARK: - Convert string to date
public extension Date {
   
   /**
    Convert string to optional date
    - parameter string: Date string
    - parameter locale: Locale to handle when user is not using 24-hour time format
    */
   static func dateFrom(string: String?, locale: Locale = Locale(identifier: "pt-BR")) -> Date? {
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
         parseFormat.locale = locale
         return parseFormat.date(from: stringValue)
      }
      return dates.first
   }
}

// MARK: - Utils
public extension Date {
   
   /**
    Verify date is equals current date
    */
   var isToday: Bool {
      return Calendar.current.isDateInToday(self)
   }
   
   /**
    Verify date is equals tomorrow
    */
   var isTomorrow: Bool {
      return Calendar.current.isDateInTomorrow(self)
   }
   
   /**
    Verify date is equals yesterday
    */
   var isYesterday: Bool {
      return Calendar.current.isDateInYesterday(self)
   }
   
   /**
    */
   var whitoutTimeStamp: Date {
      guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
         fatalError("Failed to strip time from Date object")
      }
      return date
   }
   
   /**
    Verify is date is in the same week as it
    - parameter date: Date to be compared
    */
   func isInWeek(date: Date) -> Bool {
      return Calendar.current.isDate(self, equalTo: date, toGranularity: .weekOfYear)
   }
}

//MARK: - TimeRemaing
public struct TimeRemaining {
   public let days: Int
   public let hours: Int
   public let minutes: Int
   public let seconds: Int
}

public extension Date {
   
   /**
    Calculate how long is it until this date.
    - parameter secondsFromGMT: Represents how seconds the user is from GMT, is to handle time zone
    - Returns: A struct TimeRemaining (Days, Hours, Minutes, Seconds) all as Int.
    */
   func timeRemainingSiceNow(secondsFromGMT: Double = 0) -> TimeRemaining {
      let time = NSInteger(self.timeIntervalSinceNow - secondsFromGMT)
      
      let days = (time / 86400)
      let hours = (time / 3600) % 24
      let minutes = (time / 60) % 60
      let seconds = time % 60
      
      return TimeRemaining(days: days, hours: hours, minutes: minutes, seconds: seconds)
   }
}
