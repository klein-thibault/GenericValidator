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
    case invalid(String)
}

class TextFieldValidationTests: XCTestCase {
    
    func test_whenTextFieldHasPassword_andPasswordIsValid() {
        // Given
        let textField = UITextField()
        textField.text = "qwerty"
        let result = textField.validate([isPasswordValid])
        // When
        let expectedResult = ValidationResult.valid
        // Then
        XCTAssertEqual(result, expectedResult)
    }

    func test_whenTextFieldHasPassword_andPasswordIsInvalid() {
        // Given
        let textField = UITextField()
        textField.text = nil
        let result = textField.validate([isPasswordValid])
        // When
        let expectedResult = ValidationResult.invalid([ValidationError.invalid("The password is empty")])
        // Then
        XCTAssertEqual(result, expectedResult)
    }

    private func isPasswordValid(password: String) -> ValidationResult {
        if password.isNotEmpty() {
            return .valid
        }

        return .invalid([ValidationError.invalid("The password is empty")])
    }

    private func isPhoneNumberValid(phoneNumber: String) -> ValidationResult {
        guard phoneNumber.isNotEmpty() else {
            return .invalid([ValidationError.invalid("The phone number is empty")])
        }

        if phoneNumber.isPhoneNumberValid() {
            return .valid
        }

        return .invalid([ValidationError.invalid("The phone number is invalid")])
    }

}
