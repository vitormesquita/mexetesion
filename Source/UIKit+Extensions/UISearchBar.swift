//
//  UISearchBar.swift
//  Mextension
//
//  Created by mano on 09/01/20.
//  Copyright © 2020 Vitor Mesquita. All rights reserved.
//

import UIKit

extension UISearchBar {
   
   var textField: UITextField? {
      return self.value(forKey: "searchField") as? UITextField
   }
}
