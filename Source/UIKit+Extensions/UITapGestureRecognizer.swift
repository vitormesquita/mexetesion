//
//  UITapGestureRecognizer.swift
//  Mextension
//
//  Created by Vitor Mesquita on 18/09/2018.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

// MARK: - UILabel text Gesture
public extension UITapGestureRecognizer {
   
   /**
    Verify if label was clicked in target range
    - parameter label: UILabel who will verified is was clicked
    - parameter targetRange: Range text to verify if label was cliked in some especific text
    */
   func didTapAttributedIn(label: UILabel, inRange targetRange: NSRange) -> Bool {
      // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
      let layoutManager = NSLayoutManager()
      let textContainer = NSTextContainer(size: CGSize.zero)
      let textStorage = NSTextStorage(attributedString: label.attributedText!)
      
      // Configure layoutManager and textStorage
      layoutManager.addTextContainer(textContainer)
      textStorage.addLayoutManager(layoutManager)
      
      // Configure textContainer
      textContainer.lineFragmentPadding = 0.0
      textContainer.lineBreakMode = label.lineBreakMode
      textContainer.maximumNumberOfLines = label.numberOfLines
      let labelSize = label.bounds.size
      textContainer.size = labelSize
      
      // Find the tapped character location and compare it to the specified range
      let locationOfTouchInLabel = self.location(in: label)
      let textBoundingBox = layoutManager.usedRect(for: textContainer)
      let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                        y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
      let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                   y: locationOfTouchInLabel.y - textContainerOffset.y)
      
      let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
      
      return NSLocationInRange(indexOfCharacter, targetRange)
   }
   
   /**
    Verify if UILabel was clicked in especifc text
    - parameter text: String who will checked if clicked
    */
   func tapLabelIn(text: String) -> Bool {
      guard let label = self.view as? UILabel else { return false }
      
      let labelText = label.text!
      let textRange = (labelText as NSString).range(of: text)
      
      return didTapAttributedIn(label: label, inRange: textRange)
   }
}
