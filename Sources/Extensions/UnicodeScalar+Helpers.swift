//
//  UnicodeScalar+Helpers.swift
//  GenericValidator
//
//  Created by Harlan Kellaway on 7/12/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

internal extension UnicodeScalar {
    
    /// Whether the scalar is either a letter or a digit.
    ///
    /// - Returns: True if the scalar is alphanumeric, false otherwise.
    func isAlphaNumeric() -> Bool {
        return isLetter() || isDigit()
    }
    
    /// Whether the scalar is a letter.
    ///
    /// - Returns: True if the scalar is a letter, false otherwise.
    func isLetter() -> Bool {
        return CharacterSet.letters.contains(self)
    }
    
    /// Whether the scalar is a digit.
    ///
    /// - Returns: True if the scalar is a digit, false otherwise.
    func isDigit() -> Bool {
        return CharacterSet.decimalDigits.contains(self)
    }
    
}
