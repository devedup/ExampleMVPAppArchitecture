//
//  ScoreServiceNetworkResponse.swift
//  CSExample
//
//  Created by David Casserly on 27/02/2018.
//  Copyright © 2018 DevedUp. All rights reserved.
//

import Foundation

/// We build this network response struct to match the json structure returned. It's simpler and clearer that way, and we will transform this later into our application Model struct
struct ScoreServiceNetworkResponse: Decodable {
    
    let creditReportInfo: CreditReportInfo
    
    struct CreditReportInfo: Decodable {
        
        let score: Int
        let maxScoreValue: Int
        let minScoreValue: Int
        
    }
    
}
