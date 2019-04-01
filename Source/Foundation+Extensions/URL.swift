//
//  URL.swift
//  Mextension
//
//  Created by Vitor Mesquita on 01/04/19.
//  Copyright © 2019 Vitor Mesquita. All rights reserved.
//

import Foundation

extension URL {
   
   /**
    Search value on URL path with Query name
    - parameter queryName: Query name to search on path
    */
   func valueOf(_ queryName: String) -> String? {
      guard let url = URLComponents(string: self.absoluteString) else { return nil }
      return url.queryItems?.first(where: { $0.name == queryName })?.value
   }
}
