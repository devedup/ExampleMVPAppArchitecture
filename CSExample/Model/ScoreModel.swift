//
//  ScoreModel.swift
//  CSExample
//
//  Created by David Casserly on 26/02/2018.
//  Copyright © 2018 DevedUp. All rights reserved.
//

import Foundation

struct ScoreModel {
    
    let minScore: Int
    let maxScore: Int
    let currentScore: Int
    
}

// MARK: - Build a ScoreModel from the ScoreServiceNetworkResponse
extension ScoreModel {
    
    init?(_ networkResponse: ScoreServiceNetworkResponse) {
        minScore = networkResponse.creditReportInfo.minScoreValue
        maxScore = networkResponse.creditReportInfo.maxScoreValue
        currentScore = networkResponse.creditReportInfo.score
        
        /// A little bit of validation on the data. This cold be done in various places in the app
        guard minScore < maxScore,
                currentScore >= minScore,
                currentScore <= maxScore else {
            return nil
        }
    }
    
}
