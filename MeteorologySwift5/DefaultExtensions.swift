//
//  DefaultExtensions.swift
//  MeteorologySwift5
//
//  Created by Carlos on 03/05/2020.
//  Copyright © 2020 TestCompany. All rights reserved.
//

import Foundation

extension String {
    
    var urlEncoded : String {
        // Return valid URL with certain encoding type
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlUserAllowed)!
    }
    
    var trimmed : String {
        // No spaces at the beginning or at the end
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
}
