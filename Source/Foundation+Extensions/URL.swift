//
//  URL.swift
//  Mextension
//
//  Created by Vitor Mesquita on 01/04/19.
//  Copyright © 2019 Vitor Mesquita. All rights reserved.
//

import Foundation

extension URL {
   
   func valueOf(_ queryParamaterName: String) -> String? {
      guard let url = URLComponents(string: self.absoluteString) else { return nil }
      return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
   }
}
