//
//  AsyncResult.swift
//  CSExample
//
//  Created by David Casserly on 27/02/2018.
//  Copyright © 2018 DevedUp. All rights reserved.
//

import Foundation

/// A completion handler can return this object to encapsulate the object you want or an error object and you can switch at the call site on the result
enum AsyncResult<T> {
    
    case success(T)
    case failure(ClearScoreError)
 
}

typealias AsyncResultCompletion<T> = (AsyncResult<T>) -> Void
