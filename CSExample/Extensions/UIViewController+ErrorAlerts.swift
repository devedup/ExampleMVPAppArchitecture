//
//  UIViewController+ErrorAlerts.swift
//  CSExample
//
//  Created by David Casserly on 01/03/2018.
//  Copyright © 2018 DevedUp. All rights reserved.
//

import Foundation
import UIKit

/// Presenter views which want to display errors should implement this protocol
protocol ErrorPresentable {
    func present(_ error: ClearScoreError)
}

// MARK: - Lets make all ViewControllers be ErrorPresentable
extension UIViewController: ErrorPresentable {
    
    /// Present an error from a UIAlertController, with an OK button to dimiss. You could expand on this and pass through custom handler objects
    ///
    /// - Parameter error: the error you are presenting
    func present(_ error: ClearScoreError) {
        let title = "error.general.title".localized
        let message = error.description
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "ok".localized , style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
