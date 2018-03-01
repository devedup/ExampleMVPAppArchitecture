//
//  Error.swift
//  CSExample
//
//  Created by David Casserly on 27/02/2018.
//  Copyright © 2018 DevedUp. All rights reserved.
//

import Foundation

/// App specific errors, with optional associated Error objects with more detail
///
/// You would fill this out with lots more app specific errors
///
/// - generalNetworkError: when the network fails
/// - dataError: when the data from the network has unexpected erorrs
enum ClearScoreError: Error, CustomStringConvertible {
    
    case generalNetworkError (Error?)
    case dataError (Error?)
    
    public var description: String {
        switch self {
        case .generalNetworkError:
            return "error.network".localized
        case .dataError(let error):
            let errorString = error?.localizedDescription
            return "\("error.network.data".localized) \(errorString ?? "")"
        }
    }
    
}
