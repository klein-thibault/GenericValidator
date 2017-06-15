# GenericValidator

[![Travis build status](https://img.shields.io/travis/prolificinteractive/GenericValidator.svg?style=flat-square)](https://travis-ci.org/prolificinteractive/GenericValidator)
[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/GenericValidator.svg?style=flat-square)](https://img.shields.io/cocoapods/v/GenericValidator.svg)
[![Platform](https://img.shields.io/cocoapods/p/GenericValidator.svg?style=flat-square)](http://cocoadocs.org/docsets/GenericValidator)
[![Docs](https://img.shields.io/cocoapods/metrics/doc-percent/GenericValidator.svg?style=flat-square)](http://cocoadocs.org/docsets/GenericValidator)

## Description

GenericValidator provides helper functions and protocols to help you validate any kind of data that conforms to the `Evaluatable` and `Validatable` protocols. The validation protocol takes functions that return a validation result, which can either be valid or invalid. The invalid case contains a custom error that you provide, and the final result will list all the errors that occurred during the validation process.

The framework provides `UITextField` and `String` extensions that you can directly use to validate their content.

You can also conform to the `Evaluatable` and `Validatable` protocols in your custom types to provide a more custom validation to your code.

For examples, see the [Usage](##usage) section.

This framework was inspired by these blog articles:

* [Prolific Blog](http://blog.prolificinteractive.com/2016/09/08/a-functional-approach-to-uitextfield-validation/)
* [Thibault Klein’s article 1](http://thibaultklein.com/ios/a-functional-approach-to-uitextfield-validation/)
* [Thibault Klein’s article 2](http://thibaultklein.com/ios/a-functional-approach-to-validation-using-protocol-oriented-programming/)

## Requirements

* iOS 9+
* Xcode 8
* Swift 3+

## Installation

To use in your projects, simply add the following line to your Podfile:

```bash
pod 'GenericValidator'
```

You can then use GenericValidator by importing it into your files:

```swift
import GenericValidator
```

## Usage

GenericValidator provides 2 extensions that you can use out of the box on `UITextField` and `String`. The `UITextField` extension provides a validation function, and the `String` extension an evaluation function.

Here is an example where you can use the `String` extension to evaluate if a string is a valid credit card CVC number, and validate the text field by passing the evaluating function:

```swift
enum ValidationError: Error {
    case error(String)
}

typealias CVCValidationResult = ValidationResult<ValidationError>

func isCVCValid(text: String) -> CVCValidationResult {
    let regexp = "^[0-9]{3,4}$"
    if text.evaluate(with: regexp) {
        return .valid
    }

    return .invalid([ValidationError.error("The CVC is invalid")])
}

let cvcTextField = UITextField()
cvcTextField.text = "123"
let result = cvcTextField.validate([isCVCValid]) // result is valid

cvcTextField.text = "12a"
let result = cvcTextField.validate([isCVCValid]) // result is invalid, with error "The CVC is invalid"
```

You can also conform to the protocols to evaluate and validate your custom types.

Here is an example that describes how to validate a user:

```swift
enum ValidationError: Error {
    case error(String)
}

struct User {
    let firstName: String
    let lastName: String
    let age: Int
}

typealias UserValidationResult = ValidationResult<ValidationError>

extension User: Validatable {

    func validate(_ functions: [(User) -> UserValidationResult]) -> UserValidationResult {
		return functions.map({ f in f(self) }).reduce(UserValidationResult.valid) { $0.combine($1) }
    }

}

func isUserNameValid(user: User) -> UserValidationResult {
    let regexp = "[A-Za-z]+$"
    if user.firstName.evaluate(with: regexp)
        && user.lastName.evaluate(with: regexp) {
        return .valid
    }

    return .invalid([ValidationError.error("The user name is invalid")])
}

func isUserAdult(user: User) -> ValidationResult {
    if user.age >= 18 {
        return .valid
    }

    return .invalid([ValidationError.error("The user is not an adult")])
}

let user = User(firstName: "Thibault", lastName: "Klein", age: 26)
let result = user.validate([isUserNameValid, isUserAdult]) // result is valid

let user = User(firstName: "Thibault", lastName: "Klein", age: 17)
let result = user.validate([isUserNameValid, isUserAdult]) // result is invalid with error "The user is not an adult"

let user = User(firstName: "12345", lastName: "Klein", age: 17)
let result = user.validate([isUserNameValid, isUserAdult]) // result is invalid with errors "The user name is invalid" and "The user is not an adult"
```

## Contributing to GenericValidator

To report a bug or enhancement request, feel free to file an issue under the respective heading.

If you wish to contribute to the project, fork this repo and submit a pull request. Code contributions should follow the standards specified in the [Prolific Swift Style Guide](https://github.com/prolificinteractive/swift-style-guide). 

## License

![Prolific Interactive](https://s3.amazonaws.com/prolificsitestaging/logos/Prolific_Logo_Full_Color.png)

Copyright (c) 2017 Prolific Interactive

GenericValidator is maintained and sponsored by Prolific Interactive. It may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: ./LICENSE
