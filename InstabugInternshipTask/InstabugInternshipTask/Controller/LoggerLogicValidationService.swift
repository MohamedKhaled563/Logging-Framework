//
//  LoggerLogicValidationService.swift
//  InstabugInternshipTask
//
//  Created by Mohamed Khalid on 26/05/2021.
//

import Foundation

struct LoggerLogicValidationService {
    func validateMessage(_ message: String) -> Bool{
        return message.count > 3
    }
    func addNumbers(x: Int, y: Int) -> Int {
        return x + y
    }
}
