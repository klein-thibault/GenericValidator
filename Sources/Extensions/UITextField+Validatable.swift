//
//  UITextField+Validatable.swift
//  GenericValidator
//
//  Created by Thibault Klein on 11/29/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

public extension UITextField {

    /// Validates the given functions.
    ///
    /// - Parameter functions: The functions to validate.
    /// - Returns: `true` if and only if all the functions validated.
    public func validate(_ functions: [(String) -> ValidationResult]) -> ValidationResult {
        return functions
            .map({ f in f(self.text ?? "") })
            .reduce(ValidationResult.valid) { $0.combine($1) }
    }

}
