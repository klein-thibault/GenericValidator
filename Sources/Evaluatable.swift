//
//  Evaluatable.swift
//  GenericValidator
//
//  Created by Thibault Klein on 11/29/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

/// The evaluatable protocol.
public protocol Evaluatable {

    associatedtype T

    /// Evaluates the given condition.
    ///
    /// - Parameter condition: The condition to evaluate.
    /// - Returns: `true` if and only if the condition passed.
    func evaluate(with condition: T) -> Bool

}
