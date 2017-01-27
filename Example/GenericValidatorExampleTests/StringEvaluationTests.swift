//
//  StringEvaluationTests.swift
//  GenericValidatorExample
//
//  Created by Thibault Klein on 11/29/16.
//  Copyright © 2016 Thibault Klein. All rights reserved.
//

import XCTest
@testable import GenericValidator

class StringEvaluationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_whenTextIsNotEmpty() {
        let text = "123456"
        XCTAssertTrue(text.isNotEmpty())
    }

    func test_whenTextIsEmpty() {
        let text = ""
        XCTAssertFalse(text.isNotEmpty())
    }

    func test_whenTextIsValidPhoneNumber() {
        let text = "111-111-1111"
        XCTAssertTrue(text.isPhoneNumberValid())
    }

    func test_whenTextIsInvalidPhoneNumber() {
        let text = "111-111-111"
        XCTAssertFalse(text.isPhoneNumberValid())
    }

    func test_whenTextIsValidZipCode() {
        let text = "11201"
        XCTAssertTrue(text.isZipCodeValid())
    }

    func test_whenTextIsInvalidZipCode() {
        let text = "1101"
        XCTAssertFalse(text.isZipCodeValid())
    }

    func test_whenTextIsValidState() {
        let text = "NY"
        XCTAssertTrue(text.isStateValid())
    }

    func test_whenTextIsInvalidState() {
        let text = "NYY"
        XCTAssertFalse(text.isStateValid())
    }

    func test_whenTextIsValidCVC() {
        let text = "123"
        XCTAssertTrue(text.isCVCValid())
    }

    func test_whenTextIsValidCVC_AMEX() {
        let text = "1234"
        XCTAssertTrue(text.isCVCValid())
    }

    func test_whenTextIsInvalidCVC_containsNonNumericCharacter() {
        let text = "12a"
        XCTAssertFalse(text.isCVCValid())
    }

    func test_whenTextIsInvalidCVC_tooShort() {
        let text = "12"
        XCTAssertFalse(text.isCVCValid())
    }

    func test_whenTextIsInvalidCVC_tooLong() {
        let text = "12345"
        XCTAssertFalse(text.isCVCValid())
    }

    func test_whenTextIsValidEmail_regularEmail() {
        let text = "marc@aol.com"
        XCTAssertTrue(text.isEmailValid())
    }

    func test_whenTextIsValidEmail_multipleDomainExtension() {
        let text = "marc@aol.co.uk"
        XCTAssertTrue(text.isEmailValid())
    }

    func test_whenTextIsInvalidEmail_withPlusCharacter() {
        let text = "marc+test@msn.com"
        XCTAssertFalse(text.isEmailValid())
    }

    func test_whenTextIsInvalidEmail_withUnderscoreCharacter() {
        let text = "thibault+test@_msn.com"
        XCTAssertFalse(text.isEmailValid())
    }

    func test_whenTextIsInvalidEmail_withBrokenExtension() {
        let text = "thibault@t"
        XCTAssertFalse(text.isEmailValid())
    }

    func test_whenTextIsInvalidEmail_withTooShortDomain() {
        let text = "thibault@test.c"
        XCTAssertFalse(text.isEmailValid())
    }

}
