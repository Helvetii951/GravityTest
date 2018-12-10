//
//  String+Localized.swift
//  GravityTest
//
//  Created by Renat Galiamov on 10/12/2018.
//  Copyright © 2018 Renat Galiamov. All rights reserved.
//

import Foundation

extension String {
    var localized : String {
        return NSLocalizedString(self , comment : "")
    }
    
    func localized(with comment : String) -> String {
        return NSLocalizedString(self , comment : comment)
    }
}
