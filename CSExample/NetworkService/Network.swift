//
//  Network.swift
//  CSExample
//
//  Created by David Casserly on 27/02/2018.
//  Copyright © 2018 DevedUp. All rights reserved.
//

import Foundation

protocol Network {
    
    /// Load a network resource and return the data or the error
    ///
    /// - Parameters:
    ///   - resource: the URL you are loading
    ///   - completion: on completion return the data
    func load(resource: URL, completion: @escaping AsyncResultCompletion<Data>)
    
}

/// This class would likely expand to provide many ways of connecting to the network, such as different types of requests, security, params etc. Better to keep this decoupled from the service objects, and make this resusable. You can get even more clever by making it Generic and parsing your NetworkResponse classes internally instead of returning the Data
final class DefaultNetwork: Network {
    
    func load(resource: URL, completion: @escaping AsyncResultCompletion<Data>) {
        URLSession.shared.dataTask(with:resource, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else {
                let clearScoreError = ClearScoreError.generalNetworkError(error)
                completion(AsyncResult.failure(clearScoreError))
                return
            }
            completion(AsyncResult.success(data))
        }).resume()
    }
    
}
