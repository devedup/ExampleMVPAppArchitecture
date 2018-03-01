//
//  ScoreService.swift
//  CSExample
//
//  Created by David Casserly on 26/02/2018.
//  Copyright © 2018 DevedUp. All rights reserved.
//

import Foundation

protocol ScoreService {
    
    /// Load the score either from cache, DB or Network. Return asynchronously with the result model
    ///
    /// - Parameter completion: on completion, it will cal this block with the result
    func loadScoreData(completion: @escaping AsyncResultCompletion<ScoreModel>)
    
}

final class DefaultScoreService: ScoreService {
    
    private let network: Network
    private let endPoint: URL
    
    init(network: Network = DefaultNetwork()) {
        self.network = network
        /// This will fail fast if the URL isn't well formed and will be caught at test time / QA time. Ideally you would build your URL's more managably, separating baseURL and resources
        endPoint = URL(string: "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values")!
    }
    
    func loadScoreData(completion: @escaping AsyncResultCompletion<ScoreModel>) {
        // At this point you could load from a cache service, db, network, pull in data from various other services
        network.load(resource: endPoint) { (networkResult) in
            // Return back to the main thread as the network runs in the background
            // If you are running intensive operations here, you might want to stay in the background and only dispatch back to main when necessary. But don't prematurely optimize, this is fine for now and simpler to read. 
            DispatchQueue.main.async {
                switch networkResult {
                case .success(let data):
                    do {
                        // The json decoding would potentially be moved out of the service classes and you could make your network layer generic.
                        let networkModel = try JSONDecoder().decode(ScoreServiceNetworkResponse.self, from: data)
                        // Lets now extract the network model into our application Model class. This decouples the server side model structure with our app model structure.
                        if let scoreModel = ScoreModel(networkModel) {
                            completion(AsyncResult.success(scoreModel))
                        } else {
                            completion(AsyncResult.failure(ClearScoreError.dataError(nil)))
                        }
                    } catch {
                        // Create more specific error and pass the error info on
                        completion(AsyncResult.failure(ClearScoreError.dataError(error)))
                    }
                case .failure(let error):
                    // We're just passing the network error on here, or we could transform it into specific service class error
                    completion(AsyncResult.failure(error))
                }
            }
        }
    }
    
}
