//
//  Int.swift
//  Mextension
//
//  Created by Vitor Mesquita on 25/03/19.
//  Copyright © 2019 Vitor Mesquita. All rights reserved.
//

import Foundation

public extension Double {
   
   var currency: String {
      let formatter = NumberFormatter()
      formatter.numberStyle = .currency
      formatter.currencySymbol = ""
      formatter.maximumFractionDigits = 2
      formatter.minimumFractionDigits = 0
      return formatter.string(from: NSNumber(value: self)) ?? "0,00"
   }
   
   var currencyWithouDigits: String {
      let formatter = NumberFormatter()
      formatter.numberStyle = .currency
      formatter.currencySymbol = ""
      formatter.maximumFractionDigits = 0
      formatter.minimumFractionDigits = 0
      return formatter.string(from: NSNumber(value: self)) ?? "0"
   }
   
   func currencyWith(symbol: String, digits: Int) -> String {
      let formatter = NumberFormatter()
      formatter.numberStyle = .currency
      formatter.currencySymbol = symbol
      formatter.maximumFractionDigits = digits
      formatter.minimumFractionDigits = digits
      return formatter.string(from: NSNumber(value: self)) ?? "\(symbol)0,00"
   }
}
