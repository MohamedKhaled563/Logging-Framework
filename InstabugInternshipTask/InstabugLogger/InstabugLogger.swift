//
//  InstabugLogger.swift
//  InstabugLogger
//
//  Created by Yosef Hamza on 19/04/2021.
//

import Foundation

public class InstabugLogger {
    public static var shared = InstabugLogger()

    // MARK: Logging
    public func log(_ level: Any, message: String) {
        fatalError("Not implemented")
    }

    // MARK: Fetch logs
    #warning("Replace Any with an appropriate type")
    public func fetchAllLogs() -> Any {
        fatalError("Not implemented")
    }
    
    #warning("Replace Any with an appropriate type")
    public func fetchAllLogs(completionHandler: (Any)->Void) {
        fatalError("Not implemented")
    }
}
