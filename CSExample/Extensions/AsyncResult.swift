//
//  AsyncResult.swift
//  CSExample
//
//  Created by David Casserly on 27/02/2018.
//  Copyright © 2018 DevedUp. All rights reserved.
//

import Foundation

/// A completion handler can return this object to encapsulate the object you want, generically, or an error object and you can switch at the call site on the result
enum AsyncResult<T> {
    
    case success(T)
    case failure(ClearScoreError)
 
}

/// Typealias to make the method signatures easier to read
typealias AsyncResultCompletion<T> = (AsyncResult<T>) -> Void
