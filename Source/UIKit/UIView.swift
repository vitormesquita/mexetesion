//
//  UIView.swift
//  Mextension
//
//  Created by Vitor Mesquita on 18/09/2018.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

// MARK: - Round view
public extension UIView {

    /**
     Rounds the given set of corners to the specified radius
     - parameter corners: Corners to round
     - parameter radius:  Radius to round to
     */
    public func round(corners: UIRectCorner, radius: CGFloat) {
        _round(corners: corners, radius: radius)
    }

    /**
     Rounds the given set of corners to the specified radius with a border
     - parameter corners:     Corners to round
     - parameter radius:      Radius to round to
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    public func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = _round(corners: corners, radius: radius)
        addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
    }

    /**
     Fully rounds an autolayout view (e.g. one with no known frame) with the given diameter and border
     - parameter diameter:    The view's diameter
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    public func fullyRound(diameter: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
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
    public func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
}

// MARK: - Constraints
public extension UIView {

    /**
     Add view on parent and put all constraints (top, bottom, left, right)
     - parameter subview: View to be add on parent
     */
    public func addSubviewOnEdges(_ subview: UIView) {
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

// MARK: - Gradients
public extension UIView {

    /**
     Default colors values to top and bottom gradient
     */
    public static var defaultTopBottomGradientColors: [CGColor] {
        return [UIColor.black.cgColor, UIColor.clear.cgColor, UIColor.clear.cgColor, UIColor.black.cgColor]
    }

    /**
     Default locations values to top and bottom gradient
     */
    public static var defaultTopBottomGradientLocations: [NSNumber] {
        return [0.0, 0.3, 0.6, 0.9]
    }

    /**
     Create top and bottom gradients on view
     - parameter frame: Frame that gradient will be created
     - parameter colors: Gradient's colors
     - parameter locations: Gradient's colors locations
     */
    public func addTopAndBottomGradient(frame: CGRect, colors: [CGColor] = defaultTopBottomGradientColors, locations: [NSNumber] = defaultTopBottomGradientLocations) {
        let view = UIView(frame: frame)
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = colors
        gradient.locations = locations
        view.layer.insertSublayer(gradient, at: 0)
        self.addSubview(view)
        self.bringSubview(toFront: view)
    }

    /**
     Default colors values to bottom gradient
     */
    public static var defaultBottomGradientColors: [CGColor] {
        return [UIColor.clear.cgColor, UIColor.black.cgColor]
    }

    /**
     Default locations values to bottom gradient
     */
    public static var defaultBottomGradientLocations: [NSNumber] {
        return [0.5, 0.7]
    }

    /**
     Create bottom gradient
     - parameter frame: Frame that gradient will be crated
     - parameter colors: Gradient's colors
     - parameter locations: Gradient's colors locations
     */
    func addBottomGradient(frame: CGRect, colors: [CGColor] = defaultBottomGradientColors, locations: [NSNumber] = defaultBottomGradientLocations) {
        let view = UIView(frame: frame)
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = colors
        gradient.locations = locations
        view.layer.insertSublayer(gradient, at: 0)
        self.addSubview(view)
        self.bringSubview(toFront: view)
    }
}

// MARK: - Separetor Views
public enum SeparatorViewPosition {
    case top
    case bottom
    case left
    case right
}

public extension UIView {

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
    public static var defaultSeparetorColor: UIColor {
        return UIColor(white: 0, alpha: 0.12)
    }

    /**
     Create separetor line and put on corrects positions
     - parameter color: Line's color
     - parameter size: Height or width line size
     - parameter insets: `UIEdgeInsets` to create margin on constraints
     - parameter positions: Positions where will add separetor on parent View
     */
    public func addSeparetors(color: UIColor = defaultSeparetorColor, size: CGFloat = 1, insets: UIEdgeInsets = .zero, positions: [SeparatorViewPosition]) {
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
