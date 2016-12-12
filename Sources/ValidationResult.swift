//
//  ValidationResult.swift
//  GenericValidator
//
//  Created by Thibault Klein on 12/12/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// The validation result.
///
/// - valid: Indicates that the validation passed.
/// - invalid: Indicates that the validation didn't pass, with a list of associated errors.
public enum ValidationResult {

    case valid
    case invalid([Error])

    var isValid: Bool {
        return self == .valid
    }

}

extension ValidationResult: Equatable { }

public func ==(lhs: ValidationResult, rhs: ValidationResult) -> Bool {
    switch (lhs, rhs) {
    case (.valid, .valid):
        return true
    case (.invalid(_), .invalid(_)):
        return true
    default:
        return false
    }
}
