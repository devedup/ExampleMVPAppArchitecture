//
//  ScoreViewModel.swift
//  CSExample
//
//  Created by David Casserly on 26/02/2018.
//  Copyright © 2018 DevedUp. All rights reserved.
//

import Foundation

struct ScoreViewModel {
    
    let score: Int
    let maxScore: Int
    
    var scorePercent: Double {
        return (Double(score) / Double(maxScore))
    }
    
}

// MARK: - Build a ScoreViewModel from the ScoreModel
extension ScoreViewModel {
    
    init(_ scoreModel: ScoreModel) {
        score = scoreModel.currentScore
        maxScore = scoreModel.maxScore
    }
}
