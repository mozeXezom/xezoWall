//
//  Utilities.swift
//  xezoWallpapers
//
//  Created by mozeX on 26.09.2022.
//

import Foundation
import UIKit

class Utilities {
    static func isPasswordValid(_ password: String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=[^a-z]*[a-z])(?=[^0-9]*[0-9])[a-zA-Z0-9!@#$%^&*]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
