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

    /// Returns `true` if and only if the validation result is valid.
    public var isValid: Bool {
        return self == .valid
    }

    /// Combines two validation results into one.
    ///
    /// - Parameter result: The result to combine.
    /// - Returns: The combined result.
    public func combine(_ result: ValidationResult) -> ValidationResult {
        switch (self, result) {
        case (.valid, .valid):
            return .valid
        case (.invalid(let errors), .valid):
            return .invalid(errors)
        case (.valid, .invalid(let errors)):
            return .invalid(errors)
        case (.invalid(let leftErrors), .invalid(let rightErrors)):
            return .invalid(leftErrors + rightErrors)
        }
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
