//
//  String.swift
//  Mextension
//
//  Created by Vitor Mesquita on 18/09/2018.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import Foundation

//MARK: - Formatters
public extension String {
   
   /**
    The first char uppercased
    */
   var firstUppercased: String {
      guard let first = first else { return "" }
      return String(first).uppercased() + dropFirst()
   }
   
   /**
    Format string to display a brazilian phone with mask
    */
   var displayPhone: String {
      var phone = self
      if phone.contains("+55") {
         phone = self.replacingOccurrences(of: "+55", with: "")
      }
      
      phone.insert("(", at: self.startIndex)
      phone.insert(")", at: self.index(self.startIndex, offsetBy: 3))
      phone.insert(" ", at: self.index(self.startIndex, offsetBy: 4))
      
      return phone
   }
   
   /**
    Format string to show as currency
    - parameter symbol: Currency symbol to show after string formatted
    */
   func currency(symbol: String) -> String? {
      let formatter = NumberFormatter()
      formatter.numberStyle = .currencyAccounting
      formatter.currencySymbol = symbol
      formatter.maximumFractionDigits = 2
      formatter.minimumFractionDigits = 2
      
      guard let doubleValue = self.toDouble else {
         return nil
      }
      
      let number = NSNumber(value: doubleValue)
      
      guard number != 0 else {
         return nil
      }
      
      return formatter.string(from: number)
   }
}

//MARK: - Convertions
public extension String {
   
   /**
    Transform string to double
    */
   var toDouble: Double? {
      let stringReplaced = self.replacingOccurrences(of: ",", with: ".")
      return Double(stringReplaced)
   }
   
   /**
    Transform string to double from right to left value
    */
   var toDoubleRightToLeft: Double {
      var amountWithPrefix = self
      // remove from String: "R$", ".", ","
      let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
      amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix,
                                                        options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                        range: NSRange(location: 0, length: self.count),
                                                        withTemplate: "")
      
      return (amountWithPrefix as NSString).doubleValue / 100
   }
}

//MARK: - Validations
public extension String {
   
   /**
    Validate if string is a valid email
    */
   var isEmail: Bool {
      let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
      return predicate.evaluate(with: self)
   }
}

//MARK: - Utils
public extension String {
   
   /**
    Return a string without spaces, new lines, lowecased and special characters insensitive
    */
   var trimmedWithoutSpecialChar: String {
      var trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)
      trimmed = trimmed.lowercased()
      trimmed = trimmed.folding(options: .diacriticInsensitive, locale: .current)
      return trimmed
   }
}
