//
//  Validatable.swift
//  GenericValidator
//
//  Created by Thibault Klein on 11/29/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// The validatable protocol.
public protocol Validatable {

    associatedtype T

    /// Validates the functions passed as the parameter.
    ///
    /// - Parameter functions: The functions to validate.
    /// - Returns: The validation result.
    func validate(_ functions: [(T) -> ValidationResult]) -> ValidationResult

}
