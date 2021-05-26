//
//  LoggerService.swift
//  InstabugInternshipTask
//
//  Created by Mohamed Khalid on 25/05/2021.
//

import UIKit
import CoreData

struct LoggerService {
    var savedElements: [LogElement]?
    
    mutating func insert(message: String, level: Int64, timeSpam: Date) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let backGroundContext = appDelegate.backgroundContext
            backGroundContext.performAndWait {
                let logElement = LogElement(context: backGroundContext)
                logElement.message = message
                logElement.level = level
                logElement.timestamp = timeSpam
                logElement.identifier = UUID()
                backGroundContext.insert(logElement)
                savedElements?.append(logElement)
                checkStorageLimit()
            }
        }
    }
    mutating func fetch() -> [LogElement]?{
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.backgroundContext
            context.performAndWait {
                let fetchRequest:NSFetchRequest<LogElement> = LogElement.fetchRequest()
                do {
                    savedElements = try context.fetch(fetchRequest)
                } catch {
                    print(error)
                }
            }
            return savedElements
        }
        return nil
    }
    mutating func deleteAll() {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let backgroundContext = appDelegate.backgroundContext
                backgroundContext.performAndWait {
                    let logData = fetch()
                    if let safeData = logData {
                        for element in safeData {
                            backgroundContext.delete(element)
                        }
                    }
                    self.savedElements = [LogElement]()
                }
            }
        }
    mutating func checkStorageLimit() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let backGroundContext = appDelegate.backgroundContext
            backGroundContext.performAndWait {
                let logElements = fetch()
                if var elements = logElements {
                    if (elements.count > 3) {
                        deleteEarliestElement(&elements)
                    }
                }
                do {
                    try backGroundContext.save()
                } catch  {
                    print(error)
                }
            }
        }
    }
    
    func deleteEarliestElement(_ elements: inout [LogElement]) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let backGroundContext = appDelegate.backgroundContext
            backGroundContext.performAndWait {
                elements.sort {
                    $0.timestamp! > $1.timestamp!
                }
                backGroundContext.delete(elements.last!)
                elements.removeLast()
            }
        }
    }
}
