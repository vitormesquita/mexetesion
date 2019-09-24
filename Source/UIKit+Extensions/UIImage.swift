//
//  UIImage.swift
//  Mextension
//
//  Created by Vitor Mesquita on 18/09/2018.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

public extension UIImage {
   
   /**
    Creates UIImage from a color
    - parameter color: UIColor that will be based to create a UIImage
    */
   static func fromColor(color: UIColor) -> UIImage {
      let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
      UIGraphicsBeginImageContext(rect.size)
      let context = UIGraphicsGetCurrentContext()!
      context.setFillColor(color.cgColor)
      context.fill(rect)
      
      let img = UIGraphicsGetImageFromCurrentImageContext()!
      UIGraphicsEndImageContext()
      return img
   }
   
   /**
    Check image's main color is dark
    */
   var isDark: Bool {
      return self.cgImage?.isDark ?? false
   }
}

public extension CGImage {
   
   /**
    Check image's main color is dark
    */
   var isDark: Bool {
      guard let imageData = self.dataProvider?.data else { return false }
      guard let ptr = CFDataGetBytePtr(imageData) else { return false }
      let length = CFDataGetLength(imageData)
      let threshold = Int(Double(self.width * self.height) * 0.45)
      var darkPixels = 0
      for i in stride(from: 0, to: length, by: 4) {
         let r = ptr[i]
         let g = ptr[i + 1]
         let b = ptr[i + 2]
         let luminance = (0.299 * Double(r) + 0.587 * Double(g) + 0.114 * Double(b))
         if luminance < 150 {
            darkPixels += 1
            if darkPixels > threshold {
               return true
            }
         }
      }
      
      return false
   }
}
