//
//  Validatable.swift
//  TextFieldValidator
//
//  Created by Thibault Klein on 11/29/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// The validatable protocol.
protocol Validatable {

    associatedtype T

    /// Validates the functions passed as the parameter.
    ///
    /// - Parameter functions: The functions to validate.
    /// - Returns: `true` if and only if all the functions passed the validation.
    func validate(_ functions: [T]) -> Bool

}
