//
//  CustomUserTypeValidationTests.swift
//  GenericValidatorExample
//
//  Created by Thibault Klein on 12/14/16.
//  Copyright © 2016 Thibault Klein. All rights reserved.
//

import XCTest
@testable import GenericValidator

typealias UserValidationResult = ValidationResult<ValidationError>

struct User {
    let firstName: String
    let lastName: String
    let age: Int
}

extension User: Validatable {

    func validate(_ functions: [(User) -> UserValidationResult]) -> UserValidationResult {
        return functions.map({ f in f(self) }).reduce(ValidationResult.valid) { $0.combine($1) }
    }

}

class CustomUserTypeValidationTests: XCTestCase {
    
    func test_whenUserIsValid() {
        // Given
        let user = User(firstName: "Thibault", lastName: "Klein", age: 26)
        let result = user.validate([isUserNameValid, isUserAdult])
        // When
        let expectedResult = UserValidationResult.valid
        // Then
        XCTAssertEqual(result, expectedResult)
    }

    func test_whenUserIsInvalid_becauseOfFirstName() {
        // Given
        let user = User(firstName: "Thibault1", lastName: "Klein", age: 26)
        let result = user.validate([isUserNameValid, isUserAdult])
        // When
        let expectedResult = UserValidationResult.invalid([ValidationError.error("The user name is invalid")])
        // Then
        XCTAssertEqual(result, expectedResult)
    }

    func test_whenUserIsInvalid_becauseOfLastName() {
        // Given
        let user = User(firstName: "Thibault", lastName: "Klein@", age: 26)
        let result = user.validate([isUserNameValid, isUserAdult])
        // When
        let expectedResult = UserValidationResult.invalid([ValidationError.error("The user name is invalid")])
        // Then
        XCTAssertEqual(result, expectedResult)
    }

    func test_whenUserIsInvalid_becauseOfAge() {
        // Given
        let user = User(firstName: "Thibault", lastName: "Klein", age: 17)
        let result = user.validate([isUserNameValid, isUserAdult])
        // When
        let expectedResult = UserValidationResult.invalid([ValidationError.error("The user is not an adult")])
        // Then
        XCTAssertEqual(result, expectedResult)
    }

    private func isUserNameValid(user: User) -> UserValidationResult {
        let regexp = "[A-Za-z]+$"
        if user.firstName.evaluate(with: regexp)
            && user.lastName.evaluate(with: regexp) {
            return .valid
        }

        return .invalid([ValidationError.error("The user name is invalid")])
    }

    private func isUserAdult(user: User) -> UserValidationResult {
        if user.age >= 18 {
            return .valid
        }

        return .invalid([ValidationError.error("The user is not an adult")])
    }
    
}
