//
//  UIButton.swift
//  Mextension
//
//  Created by Vitor Mesquita on 18/09/2018.
//  Copyright © 2018 Vitor Mesquita. All rights reserved.
//

import UIKit

public extension UIButton {

    /**
     Set title without animation
     - parameter title: Button's title
     - parameter state: Button's state to show especific title
     */
    public func setTitleWithoutAnimation(_ title: String?, for state: UIControl.State) {
        UIView.performWithoutAnimation {[weak self] in
            guard let strongSelf = self else { return }
            strongSelf.setTitle(title, for: state)
            strongSelf.layoutIfNeeded()
        }
    }
}
