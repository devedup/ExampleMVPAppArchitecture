//
//  UIViewController+ActivityIndicator.swift
//  CSExample
//
//  Created by David Casserly on 01/03/2018.
//  Copyright © 2018 DevedUp. All rights reserved.
//

import Foundation
import UIKit

/// Presenter views which want to display activity should implement this protocol
protocol ActivityIndicatorPresentable {
    func presentActivityIndicator()
    func dismissActivityIndicator()
}

// MARK: - Lets make all ViewControllers be ActivityIndicatorPresentable
extension UIViewController: ActivityIndicatorPresentable {
    
    private struct AssociatedKeys {
        static var ActivityIndicator = "ActivityIndicator"
    }
    
    /// Present an activity indicator
    /// As we can't add properties to an extension, we're using the ObjC runtime to add an associated object to the instance. When we dismiss the activity indicator, we can look it up again
    func presentActivityIndicator() {
        dismissActivityIndicator()
        
        // Create an activity indicator and centre it on the screen
        let activityIndicator =  UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.centreInSuperview()
        view.bringSubview(toFront: activityIndicator)
        activityIndicator.startAnimating()
        objc_setAssociatedObject(self, &AssociatedKeys.ActivityIndicator, activityIndicator as UIActivityIndicatorView?, .OBJC_ASSOCIATION_RETAIN_NONATOMIC )
    }
    
    /// Dismiss the current activity indicator displayed on the screen
    func dismissActivityIndicator() {
        if let activityIndicator = objc_getAssociatedObject(self, &AssociatedKeys.ActivityIndicator) as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
        }
    }
    
}
