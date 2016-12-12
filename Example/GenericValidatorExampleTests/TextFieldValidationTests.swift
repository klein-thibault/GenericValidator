//
//  TextFieldValidationTests.swift
//  GenericValidatorExample
//
//  Created by Thibault Klein on 12/12/16.
//  Copyright © 2016 Thibault Klein. All rights reserved.
//

import XCTest
@testable import GenericValidator

enum ValidationError: Error {
    case error(String)
}

class TextFieldValidationTests: XCTestCase {
    
    func test_whenTextFieldHasPassword_andPasswordIsValid() {
        // Given
        let textField = UITextField()
        textField.text = "qwerty"
        let result = textField.validate([isPasswordEmpty])
        // When
        let expectedResult = ValidationResult.valid
        // Then
        XCTAssertEqual(result, expectedResult)
    }

    func test_whenTextFieldHasPassword_andPasswordIsInvalid() {
        // Given
        let textField = UITextField()
        textField.text = nil
        let result = textField.validate([isPasswordEmpty])
        // When
        let expectedResult = ValidationResult.invalid([ValidationError.error("The password is empty")])
        // Then
        XCTAssertEqual(result, expectedResult)
    }

    func test_whenTextFieldHasPassword_andPasswordIsStrong() {
        // Given
        let textField = UITextField()
        textField.text = "abcdefghij123456"
        let result = textField.validate([isPasswordEmpty, isPasswordStrong])
        // When
        let expectedResult = ValidationResult.valid
        // Then
        XCTAssertEqual(result, expectedResult)
    }

    func test_whenTextFieldHasPassword_andPasswordIsWeak() {
        // Given
        let textField = UITextField()
        textField.text = "abcd"
        let result = textField.validate([isPasswordEmpty, isPasswordStrong])
        // When
        let expectedResult = ValidationResult.invalid([ValidationError.error("The password is too short"),
                                                       ValidationError.error("The password doesn't contain a digit")])
        // Then
        XCTAssertEqual(result, expectedResult)
    }

    private func isPasswordEmpty(password: String) -> ValidationResult {
        if password.isNotEmpty() {
            return .valid
        }

        return .invalid([ValidationError.error("The password is empty")])
    }

    private func isPasswordStrong(password: String) -> ValidationResult {
        var errors = [ValidationError]()

        if password.characters.count <= 7 {
            errors.append(.error("The password is too short"))
        }

        if password.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil {
            errors.append(.error("The password doesn't contain a digit"))
        }

        if errors.isEmpty {
            return .valid
        }

        return .invalid(errors)
    }

}