//  CDQueriesManager
//  CDGenerator
//
//  Created by CDGenerator on 05/21/2020.
//  Copyright © 2020 CDGenerator. All rights reserved.
//


import UIKit
import CoreData

class CDQueriesManager: NSObject {
    
    static let shared = CDQueriesManager();
    
    private override init() {
        super.init();
    }
    
    
    //MARK:- City APIs
    
    func save(city: CityModel) {
        
        let context = CoreDataManager.shared.managedObjectContext
        let predicate = city.identityPredicate
        let fetchResults = CoreDataManager.shared.fetchRequestForEntity(entityName: "City", predicate: predicate)
        var object: NSManagedObject
        if(fetchResults !=  nil && fetchResults!.count > 0) {
            object = fetchResults?.first as! NSManagedObject
        } else {
            object = NSEntityDescription.insertNewObject(forEntityName: "City", into: context)
        }
        
        object.setValue(city.area, forKey: "area")
        object.setValue(city.id, forKey: "id")
        object.setValue(city.isCapital, forKey: "isCapital")
        object.setValue(city.name, forKey: "name")
        object.setValue(city.population, forKey: "population")
        
        CoreDataManager.shared.saveContext()
    }
    
    func queryCityList() -> [CityModel] {
        let fetchResults = CoreDataManager.shared.fetchRequestForEntity(entityName: "City", predicate: nil);
        var list = [CityModel]();
        for object in fetchResults! {
            let model = CityModel.init(managedObject: object as! NSManagedObject);
            list.append(model);
        }
        return list;
    }
    
    
    func queryCity(id: String) -> CityModel? {
        let predicate = NSPredicate.init(format: CityModel.identityKey + " = %@", id)
        
        let fetchResults = CoreDataManager.shared.fetchRequestForEntity(entityName: "City", predicate: predicate);
        if fetchResults != nil  && fetchResults!.first != nil {
            let model = CityModel.init(managedObject: fetchResults?.first as! NSManagedObject);
            return model;
        }
        return nil;
    }
    
    func delete(city: CityModel) {
        let context = CoreDataManager.shared.managedObjectContext;
        let predicate = city.identityPredicate;
        let fetchResults = CoreDataManager.shared.fetchRequestForEntity(entityName: "City", predicate: predicate);
        if(fetchResults !=  nil && fetchResults!.count > 0) {
            context.delete(fetchResults!.first as! NSManagedObject);
            CoreDataManager.shared.saveContext();
        }
    }
    
    //MARK:- Country APIs
    
    func save(country: CountryModel) {
        
        let context = CoreDataManager.shared.managedObjectContext
        let predicate = country.identityPredicate
        let fetchResults = CoreDataManager.shared.fetchRequestForEntity(entityName: "Country", predicate: predicate)
        var object: NSManagedObject
        if(fetchResults !=  nil && fetchResults!.count > 0) {
            object = fetchResults?.first as! NSManagedObject
        } else {
            object = NSEntityDescription.insertNewObject(forEntityName: "Country", into: context)
        }
        
        object.setValue(country.area, forKey: "area")
        object.setValue(country.callingCode, forKey: "callingCode")
        object.setValue(country.code, forKey: "code")
        object.setValue(country.flag, forKey: "flag")
        object.setValue(country.id, forKey: "id")
        object.setValue(country.name, forKey: "name")
        object.setValue(country.population, forKey: "population")
        
        CoreDataManager.shared.saveContext()
    }
    
    func queryCountryList() -> [CountryModel] {
        let fetchResults = CoreDataManager.shared.fetchRequestForEntity(entityName: "Country", predicate: nil);
        var list = [CountryModel]();
        for object in fetchResults! {
            let model = CountryModel.init(managedObject: object as! NSManagedObject);
            list.append(model);
        }
        return list;
    }
    
    
    func queryCountry(id: String) -> CountryModel? {
        let predicate = NSPredicate.init(format: CountryModel.identityKey + " = %@", id)
        
        let fetchResults = CoreDataManager.shared.fetchRequestForEntity(entityName: "Country", predicate: predicate);
        if fetchResults != nil  && fetchResults!.first != nil {
            let model = CountryModel.init(managedObject: fetchResults?.first as! NSManagedObject);
            return model;
        }
        return nil;
    }
    
    func delete(country: CountryModel) {
        let context = CoreDataManager.shared.managedObjectContext;
        let predicate = country.identityPredicate;
        let fetchResults = CoreDataManager.shared.fetchRequestForEntity(entityName: "Country", predicate: predicate);
        if(fetchResults !=  nil && fetchResults!.count > 0) {
            context.delete(fetchResults!.first as! NSManagedObject);
            CoreDataManager.shared.saveContext();
        }
    }
    
    func queryCityList(name: String) -> [CityModel]? {
        
        let predicate =  NSPredicate.init(format: "name BEGINSWITH[c] %@ ", name )
        let sortDescriptors = [NSSortDescriptor(key:"name", ascending:true)]
        
        let fetchResults = CoreDataManager.shared.fetchRequestForEntity(entityName: "City", predicate: predicate, sortDescriptors: sortDescriptors) as? [NSManagedObject];
        
        if fetchResults != nil {
            let models = fetchResults!.map { (managedObject) -> CityModel in
                let model = CityModel.init(managedObject: managedObject);
                return model
            }
            return models;
        }
        return nil;
    }
    
    func queryCountryList(name: String) -> [CountryModel]? {
        
        let predicate =  NSPredicate.init(format: "name CONTAINS[c] %@ ", name )
        let sortDescriptors = [NSSortDescriptor(key:"name", ascending:true)]
        
        let fetchResults = CoreDataManager.shared.fetchRequestForEntity(entityName: "Country", predicate: predicate, sortDescriptors: sortDescriptors) as? [NSManagedObject];
        
        if fetchResults != nil {
            let models = fetchResults!.map { (managedObject) -> CountryModel in
                let model = CountryModel.init(managedObject: managedObject);
                return model
            }
            return models;
        }
        return nil;
    }
}

