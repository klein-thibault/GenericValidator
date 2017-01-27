//
//  String+Evaluatable.swift
//  GenericValidator
//
//  Created by Thibault Klein on 11/29/16.
//  Copyright © 2016 Prolific Interactive. All rights reserved.
//

public extension String {

    /// Evaluates the given condition.
    ///
    /// - Parameter condition: The condition to evaluate
    /// - Returns: `true` if and only if the condition passed the evaluation.
    public func evaluate(with condition: String) -> Bool {
        guard let range = range(of: condition, options: .regularExpression, range: nil, locale: nil) else {
            return false
        }

        return range.lowerBound == startIndex && range.upperBound == endIndex
    }

    /// Indicates if the text field's text is not empty.
    ///
    /// - Returns: `true` if and only if the text is not empty.
    func isNotEmpty() -> Bool {
        return !isEmpty
    }

    /// Indicates if the phone number is valid.
    ///
    /// - Returns: `true` if and only if the text is a phone number.
    func isPhoneNumberValid() -> Bool {
        var cleanedText = replacingOccurrences(of: "-", with: "")
        cleanedText = cleanedText.replacingOccurrences(of: "(", with: "")
        cleanedText = cleanedText.replacingOccurrences(of: ")", with: "")
        cleanedText = cleanedText.replacingOccurrences(of: " ", with: "")
        cleanedText = cleanedText.replacingOccurrences(of: ".", with: "")
        cleanedText = cleanedText.replacingOccurrences(of: "/", with: "")
        let regexp = "^[0-9]{10}$"
        return cleanedText.evaluate(with: regexp)
    }

    /// Indicates if the zip code is valid.
    ///
    /// - Returns: `true` if and only if the text is a zip code.
    func isZipCodeValid() -> Bool {
        let regexp = "^[0-9]{5}$"
        return evaluate(with: regexp)
    }

    /// Indicates if the US state is valid.
    ///
    /// - Returns: `true` if and only if the text is a state.
    func isStateValid() -> Bool {
        let regexp = "^[A-Z]{2}$"
        return evaluate(with: regexp)
    }

    /// Indicates if the credit card CVC number is valid.
    ///
    /// - Returns: `true` if the text is a valid credit card CVC number.
    func isCVCValid() -> Bool {
        let regexp = "^[0-9]{3,4}$"
        return evaluate(with: regexp)
    }

    /// Indicates if the email is valid.
    ///
    /// - Returns: `true` if and only if the text is a valid email.
    func isEmailValid() -> Bool {
        let regexp = "[A-Z0-9a-z._]+@([\\w\\d]+\\.[\\w\\d\\.]{2,64})"
        return evaluate(with: regexp)
    }

}
