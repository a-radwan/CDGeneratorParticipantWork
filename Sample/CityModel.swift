//  CityModel
//  CDGenerator
//
//  Created by CDGenerator on 05/21/2020.
//  Copyright © 2020 CDGenerator. All rights reserved.
//

import UIKit
import CoreData

class CityModel: NSObject {

	var area: Float?
	var id: String?
	var isCapital: Bool?
	var name: String?
	var population: Int?
	var country: CountryModel?

    override init() {
    
    }

	init(managedObject: NSManagedObject) {

		self.area = (managedObject.value(forKey: "area") as? Float)
		self.id = (managedObject.value(forKey: "id") as? String)
		self.isCapital = (managedObject.value(forKey: "isCapital") as? Bool)
		self.name = (managedObject.value(forKey: "name") as? String)
		self.population = (managedObject.value(forKey: "population") as? Int)

	}

	func save() {

		if !Thread.current.isMainThread {
			DispatchQueue.main.async {
				self.save()
			}
			return
		}
		CDQueriesManager.shared.save(city: self)
	}

	func delete() {

		if !Thread.current.isMainThread {
			DispatchQueue.main.async {
				self.delete()
			}
			return
		}
		CDQueriesManager.shared.delete(city: self)
	}

    //MARK:- Model Identity
    var identityPredicate: NSPredicate {
        //TODO: Update identity predicate
    return NSPredicate.init(format: CityModel.identityKey + " = %@", self.identityValue)

    }
    static var identityKey: String {
        //TODO: If your model identity key is not 'id', you need to change update it from here
        return "id";
    }
    var identityValue: String {
        //TODO: If your model identity key is not 'id', you need to change update it from here
        return self.id!;
    }

}