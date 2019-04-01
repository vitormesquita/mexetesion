//
//  UITextField.swift
//  Mextension
//
//  Created by Vitor Mesquita on 18/09/2018.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

// MARK: - ToolBar
public extension UITextField {
   
   /**
    Create textField toolBar
    - parameter tintColor: Toolbar button's tint color
    - parameter backgroundColor: Toolbar's background color
    - parameter rightButton: Optional right toolbar button
    - parameter leftButton: Optional left toolbar button
    */
   public func addToolBar(tintColor: UIColor, backgroundColor: UIColor = .white, rightButton: UIBarButtonItem? = nil, leftButton: UIBarButtonItem? = nil) {
      let toolBar = UIToolbar()
      toolBar.isTranslucent = true
      toolBar.tintColor = tintColor
      toolBar.barTintColor = backgroundColor
      toolBar.sizeToFit()
      
      var buttons: [UIBarButtonItem] = []
      
      if let rightButton = rightButton {
         buttons.append(rightButton)
      }
      
      let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
      buttons.append(spaceButton)
      
      if let leftButton = leftButton {
         buttons.append(leftButton)
      }
      
      toolBar.setItems(buttons, animated: false)
      toolBar.isUserInteractionEnabled = true
      
      self.inputAccessoryView = toolBar
   }
}
