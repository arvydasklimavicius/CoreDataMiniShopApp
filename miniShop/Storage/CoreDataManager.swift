//
//  CoreDataManager.swift
//  miniShop
//
//  Created by Arvydas Klimavicius on 2021-03-29.
//

import Foundation
import CoreData

class CoreDataManager {
    
    private static let modelName = "miniShop"
    
    static var managedContext: NSManagedObjectContext = {
        return storeContainer.viewContext
    }()
    
    private static var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static func saveContext() throws {
        guard managedContext.hasChanges else { return }
        
        try managedContext.save()
    }
    
    
//    private let modelName: String
//
//    init(modelName: String = "miniShop") {
//        self.modelName = modelName
//    }
//
//    lazy var managedContext: NSManagedObjectContext = {
//        return self.storeContainer.viewContext
//    }()
//
//    private lazy var storeContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: self.modelName)
//
//        container.loadPersistentStores { (_, error) in
//            if let error = error {
//                print("Error \(error)")
//            }
//        }
//        return container
//    }()
//
////    @discardableResult
////    func saveContext() -> Bool {
////        guard managedContext.hasChanges else { return true }
////
////        do {
////            try managedContext.save()
////            return true
////        } catch let error as NSError {
////            print("Unresolved Error \(error), \(error.userInfo)")
////            return false
////        }
////    }
//
//    static func saveContext() throws {
//        guard managedContext.hasChanges else { return }
//
//        try managedContext.save()
//    }
}

