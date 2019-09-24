//
//  UIView.swift
//  Mextension
//
//  Created by Vitor Mesquita on 18/09/2018.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit
/**
 Class to include all UIView extensions. We've separated each extension in common methods extensions:
 1. Round
 2. Constraints
 3. Gradients
 4. Separetor View
 5. Shadow
 6. Utils
 **/

// MARK: - 1. Round
public extension UIView {
   
   /**
    Rounds the given set of corners to the specified radius
    - parameter corners: Corners to round
    - parameter radius:  Radius to round to
    */
   func round(corners: UIRectCorner, radius: CGFloat) {
      _round(corners: corners, radius: radius)
   }
   
   /**
    Rounds the given set of corners to the specified radius with a border
    - parameter corners:     Corners to round
    - parameter radius:      Radius to round to
    - parameter borderColor: The border color
    - parameter borderWidth: The border width
    */
   func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
      let mask = _round(corners: corners, radius: radius)
      addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
   }
   
   /**
    Fully rounds an autolayout view (e.g. one with no known frame) with the given diameter and border
    - parameter diameter:    The view's diameter
    - parameter borderColor: The border color
    - parameter borderWidth: The border width
    */
   func fullyRound(diameter: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
      layer.masksToBounds = true
      layer.cornerRadius = diameter / 2
      layer.borderWidth = borderWidth
      layer.borderColor = borderColor.cgColor
   }
   
   /**
    Create Bezier Path to put as mask on view
    - parameter corners: Corners to round
    - parameter radius:  Radius to round to
    */
   @discardableResult func _round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
      let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
      let mask = CAShapeLayer()
      mask.path = path.cgPath
      self.layer.mask = mask
      return mask
   }
   
   /**
    Create border sublayer
    - parameter mask: round mask to copy path
    - parameter borderColor: Border color
    - parameter borderWidth: Border width
    */
   func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
      let borderLayer = CAShapeLayer()
      borderLayer.path = mask.path
      borderLayer.fillColor = UIColor.clear.cgColor
      borderLayer.strokeColor = borderColor.cgColor
      borderLayer.lineWidth = borderWidth
      borderLayer.frame = bounds
      layer.addSublayer(borderLayer)
   }
}

// MARK: - 2. Constraints
public extension UIView {
   
   /**
    Add view on parent and put all constraints (top, bottom, left, right)
    - parameter subview: View to be add on parent
    */
   func addSubviewOnEdges(_ subview: UIView) {
      self.addSubview(subview)
      self.translatesAutoresizingMaskIntoConstraints = false
      subview.translatesAutoresizingMaskIntoConstraints = false
      
      let edgesConstraints = [
         subview.topAnchor.constraint(equalTo: self.topAnchor),
         subview.bottomAnchor.constraint(equalTo: self.bottomAnchor),
         subview.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         subview.trailingAnchor.constraint(equalTo: self.trailingAnchor)
      ]
      
      NSLayoutConstraint.activate(edgesConstraints)
   }
}

// MARK: - 3. Gradients
public extension UIView {
   
   /**
    */
   @discardableResult func addGradient(colors: [UIColor], locations: [NSNumber]) -> CAGradientLayer {
      let gradient = CAGradientLayer()
      gradient.colors = colors.map { $0.cgColor }
      gradient.locations = locations
      self.layer.insertSublayer(gradient, at: 0)
      return gradient
   }
   
   /**
    Create top and bottom gradients on view
    - parameter frame: Frame that gradient will be created
    - parameter colors: Gradient's colors
    - parameter locations: Gradient's colors locations
    */
   @discardableResult func addTopAndBottomGradient(colors: [UIColor]? = nil, locations: [NSNumber]? = nil) -> CAGradientLayer {
      let _color = colors ?? [UIColor.black, UIColor.clear, UIColor.clear, UIColor.black]
      let _locations = locations ?? [0.0, 0.3, 0.6, 0.9]
      return addGradient(colors: _color, locations: _locations)
   }
   
   /**
    Create bottom gradient
    - parameter frame: Frame that gradient will be crated
    - parameter colors: Gradient's colors
    - parameter locations: Gradient's colors locations
    */
   @discardableResult func addBottomGradient(colors: [UIColor]? = nil, locations: [NSNumber]? = nil) -> CAGradientLayer {
      let _color = colors ?? [UIColor.clear, UIColor.black]
      let _locations = locations ?? [0, 0.8]
      return addGradient(colors: _color, locations: _locations)
   }
}

// MARK: - 4. Separetor Views
public extension UIView {
   
   enum SeparatorViewPosition {
      case top
      case bottom
      case left
      case right
   }
   
   /**
    Create line separetor view
    - parameter color: Separetor line color
    - parameter position: Position where line view will be
    - parameter size: Line's size
    */
   static func separetorView(color: UIColor, position: SeparatorViewPosition, size: CGFloat) -> UIView {
      let separetorView = UIView()
      separetorView.backgroundColor = color
      separetorView.translatesAutoresizingMaskIntoConstraints = false
      
      let sizeFormatted = (size / UIScreen.main.nativeScale)
      
      switch position {
      case .bottom, .top:
         separetorView.heightAnchor.constraint(equalToConstant: sizeFormatted).isActive = true
         
      case .right, .left:
         separetorView.widthAnchor.constraint(equalToConstant: sizeFormatted).isActive = true
      }
      
      return separetorView
   }
   
   /**
    Default separetor line color
    */
   static var defaultSeparetorColor: UIColor {
      return UIColor(white: 0, alpha: 0.12)
   }
   
   /**
    Create separetor line and put on corrects positions
    - parameter color: Line's color
    - parameter size: Height or width line size
    - parameter insets: `UIEdgeInsets` to create margin on constraints
    - parameter positions: Positions where will add separetor on parent View
    */
   func addSeparetors(color: UIColor = defaultSeparetorColor, size: CGFloat = 1, insets: UIEdgeInsets = .zero, positions: [SeparatorViewPosition]) {
      for position in positions {
         let separetorView = UIView.separetorView(color: color, position: position, size: size)
         
         var layoutConstraints: [NSLayoutConstraint] = []
         
         self.addSubview(separetorView)
         self.translatesAutoresizingMaskIntoConstraints = false
         
         switch position {
         case .top:
            layoutConstraints = [
               separetorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets.left),
               separetorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -insets.right),
               separetorView.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top)
            ]
            
         case .bottom:
            layoutConstraints = [
               separetorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets.left),
               separetorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -insets.right),
               separetorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -insets.bottom)
            ]
            
         case .right:
            layoutConstraints = [
               separetorView.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top),
               separetorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -insets.right),
               separetorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -insets.bottom)
            ]
            
         case .left:
            layoutConstraints = [
               separetorView.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top),
               separetorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets.left),
               separetorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -insets.bottom)
            ]
         }
         
         NSLayoutConstraint.activate(layoutConstraints)
      }
   }
}

// MARK: - 5. Shadow
public extension UIView {
   
   /**
    Create view shadow by default on bottom
    - parameter radius: Sets how wide the shadow should be.
    - parameter opacity: Sets how transparent the shadow is, where 0 is invisible and 1 is as strong as possible.
    - parameter height: Sets how long the shadow could be
    - parameter color: Sets shadow color
    */
   func shadow(radius: CGFloat = 2, opacity: Float = 1, height: CGFloat = 2, color: UIColor = .black) {
      self.layer.shadowRadius = radius
      self.layer.shadowOpacity = opacity
      self.layer.shadowOffset = CGSize(width: 0, height: height)
      self.layer.shadowColor = color.cgColor
      
   }
}

// MARK: - 6. Utils
public extension UIView {
   
   /**
    Return UIView's class name
    - Usually this name is to use as `.xib` name
    */
   static var className: String {
      return String(describing: self)
   }
}
