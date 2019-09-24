//
//  UIViewController.swift
//  Mextension
//
//  Created by Vitor Mesquita on 18/09/2018.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

public extension UIViewController {
   
   /**
    Remove UIViewController from parentViewController
    */
   func removeDefinitely() {
      self.willMove(toParent: nil)
      self.view.removeFromSuperview()
      self.removeFromParent()
   }
}
