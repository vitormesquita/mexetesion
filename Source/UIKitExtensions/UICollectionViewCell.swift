//
//  UICollectionView.swift
//  Mextension
//
//  Created by Vitor Mesquita on 18/09/2018.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

// MARK: - Size
public extension UICollectionViewCell {

    /**
     Calculate UICollectionViewCell's height by content and width
     - parameter width: UICollectionViewCell's width
     */
    public func heightForWidth(width: CGFloat) -> CGFloat {
        contentView.frame = CGRect(x: contentView.frame.origin.x, y: contentView.frame.origin.y, width: width, height: contentView.frame.size.height)
        contentView.layoutIfNeeded()

        return contentView.systemLayoutSizeFitting(CGSize(width: width, height: CGFloat.infinity),
                                                   withHorizontalFittingPriority: UILayoutPriority(rawValue: 999),
                                                   verticalFittingPriority: UILayoutPriority(rawValue: 50)).height
    }
}
