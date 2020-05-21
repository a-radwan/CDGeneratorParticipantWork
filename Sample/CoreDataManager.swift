//  CoreDataManager
//  CDGenerator
//
//  Created by CDGenerator on 05/21/2020.
//  Copyright © 2020 CDGenerator. All rights reserved.
//


import UIKit
import CoreData

let kModuleName = "Sample"

class CoreDataManager: NSObject {
    
    var saveOperationQueue = OperationQueue();
    
    static let shared = CoreDataManager();
    
    private override init() {
        super.init();
        self.saveOperationQueue.maxConcurrentOperationCount = 1;
    }

    lazy var managedObjectContext: NSManagedObjectContext = {
        
        let coordinator = CoreDataManager.shared.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: kModuleName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let directory = self.applicationDocumentsDirectory
        
        let url = directory.appendingPathComponent(String(format: "%@.sqlite",kModuleName))
        
        let options = [ NSMigratePersistentStoresAutomaticallyOption : true,
                        NSInferMappingModelAutomaticallyOption : true ]
        
        
        do {
            try coordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch var error as NSError {
            coordinator = nil
            NSLog("Unresolved error \(error), \(error.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        return coordinator
    }()
    
    lazy var applicationDocumentsDirectory: URL = {
        
        //TEMP: Add App group identifier
        //return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "your.app.group.dentifier")!

        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory

        }()

    
    func saveContext () {
        let context = self.managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error %@, %@", error, nserror.userInfo);
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchRequestForEntity(entityName: String, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]? = nil) -> [Any]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        if predicate  != nil {
            request.predicate = predicate;
        }
        request.sortDescriptors = sortDescriptors;
        do {
            return try managedObjectContext.fetch(request)
        } catch let error as NSError {
            print(error)
            return nil;
        }
    }

    func deleteContentsOfEntity(entityName: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest.init(fetchRequest: request);
        
        do {
             try managedObjectContext.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
}
