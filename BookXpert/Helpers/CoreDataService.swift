//
//  CoreDataService.swift
//  BookXpert
//
//  Created by Sree Lakshman on 16/04/25.
//

import Foundation
import CoreData
import UIKit

class CoreDataService {
    
    static let shared = CoreDataService()

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "BookXpert")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // Save changes, if needed.
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Save User Details
    
    /// Saves the authenticated user's details in Core Data.
    func saveUser(uid: String, email: String, displayName: String?) {
        // Create a new instance of the UserEntity
        guard let entity = NSEntityDescription.entity(forEntityName: "UserEntity", in: context) else { return }
        let newUser = NSManagedObject(entity: entity, insertInto: context)
        newUser.setValue(uid, forKey: "uid")
        newUser.setValue(email, forKey: "email")
        newUser.setValue(displayName, forKey: "displayName")
        
        // Save the context to persist data
        do {
            try context.save()
            print("User saved in Core Data.")
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
}
