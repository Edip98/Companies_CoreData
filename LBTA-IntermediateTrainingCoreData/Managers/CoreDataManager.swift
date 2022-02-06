//
//  CoreDataManager.swift
//  LBTA-IntermediateTrainingCoreData
//
//  Created by Эдип on 02.02.2022.
//

import Foundation
import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentConatainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "IntermediateTrainingModel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Loading for store failed: \(error)")
            }
        }
        return container
    }()
    
    
     func fetchCompanies() -> [Company] {
        let context = persistentConatainer.viewContext
        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")
        
        do {
            let companies = try context.fetch(fetchRequest)
            
            return companies
            
        } catch let fetchError {
            print("Filed to fetch companies:", fetchError)
            return []
        }
    }
    
    
    func createEmployee(employeeName: String, employeeType: String, birthday: Date, company: Company) -> (Employee?, Error?) {
        let context = persistentConatainer.viewContext
        
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee
        employee.setValue(employeeName, forKey: "name")
        
        employee.company = company
        employee.birthday = birthday
        employee.type = employeeType
        
        do {
            try context.save()
            return (employee, nil)
        } catch let error {
            print("Failed to create employee:", error)
            return (nil, error)
        }
    }
}
