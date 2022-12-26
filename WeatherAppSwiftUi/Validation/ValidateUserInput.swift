//
//  ValidateUserInput\.swift
//  WeatherAppSwiftUi
//
//  Created by swostik gautam on 23/12/2022.
//

import Foundation


struct ValidateUserInput {
    var errorMessage: String?
    var success: Bool = false
}


class UserInputValidation {
    func validateUserInput(location : String) -> ValidateUserInput {
        if(location.isEmpty) {
            return ValidateUserInput(errorMessage: "Please Enter Location", success: false)
        }
        return ValidateUserInput(success: true)
    }
}
