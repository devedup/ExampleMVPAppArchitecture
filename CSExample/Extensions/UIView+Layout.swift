//
//  UIView+Layout.swift
//  CSExample
//
//  Created by David Casserly on 01/03/2018.
//  Copyright © 2018 DevedUp. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Convenience method to centre this view in its superview
    func centreInSuperview() {
        guard let superview = self.superview else {
            preconditionFailure("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `constrainViewToSuperview()` to fix this.")
        }
        translatesAutoresizingMaskIntoConstraints = false
        
        let x = centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        let y = centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        
        NSLayoutConstraint.activate([x, y])
    }
    
}
