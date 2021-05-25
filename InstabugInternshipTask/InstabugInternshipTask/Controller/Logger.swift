//
//  Logger.swift
//  InstabugInternshipTask
//
//  Created by Mohamed Khalid on 25/05/2021.
//

import Foundation

struct Logger{
    let loggerService = LoggerService()
    
    func addLogElement(message: String, level: Int64) {
        var verifiedMessage = message
        validateMessage(message: &verifiedMessage)
        loggerService.insert(message: verifiedMessage, level: level, timeSpam: Date())
    }
    func validateMessage(message: inout String) {
        if (message.count > 1000) {
            let lastIndex = message.index(message.startIndex, offsetBy: 999)
            message = message[message.startIndex...lastIndex] + "..."
        }
    }
    func getLog() -> [LogElement]? {
        return loggerService.fetch()
    }
    func printLog() {
        let log = getLog()
        if let safeLog = log {
            for logElement in safeLog {
                print ("Message: \(logElement.message)\nLevel: \(logElement.level)\nTimestamp: \(logElement.timestamp)\n")
                print("________________________________\n")
            }
        }
    }
    func deleteLog() {
        loggerService.deleteAll()
    }
}
