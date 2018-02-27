//
//  String+Localization.swift
//  CSExample
//
//  Created by David Casserly on 27/02/2018.
//  Copyright © 2018 DevedUp. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
