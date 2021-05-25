//
//  LoggerService.swift
//  InstabugInternshipTask
//
//  Created by Mohamed Khalid on 25/05/2021.
//

import UIKit
import CoreData

struct LoggerService {
    
    func insert(message: String, level: Int64, timeSpam: Date) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let logElement = LogElement(context: context)
            logElement.message = message
            logElement.level = level
            logElement.timestamp = timeSpam
            context.insert(logElement)
            let logElements = fetch()
            if var elements = logElements {
                if (elements.count > 1000) {
                    // Delete earliest log
                    elements.sort {
                        $0.timestamp! > $1.timestamp!
                    }
                    context.delete(elements.last!)
                    elements.removeLast()
                }
            }
            do {
                try context.save()
            } catch  {
                print(error)
            }
        }
    }
    
    func fetch() -> [LogElement]?{
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest:NSFetchRequest<LogElement> = LogElement.fetchRequest()
            do {
                return try context.fetch(fetchRequest)
            } catch {
                print(error)
                return nil
            }
        }
        return nil
    }
    func deleteAll() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let logData = fetch()
            if let safeData = logData {
                for element in safeData {
                    context.delete(element)
                }
            }
        }
        
    }
}
