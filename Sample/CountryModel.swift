//  CountryModel
//  CDGenerator
//
//  Created by CDGenerator on 05/21/2020.
//  Copyright © 2020 CDGenerator. All rights reserved.
//

import UIKit
import CoreData

class CountryModel: NSObject {

	var area: Float?
	var callingCode: String?
	var code: String?
	var flag: String?
	var id: String?
	var name: String?
	var population: Int?
	var cities: [CityModel]?

    override init() {
    
    }

	init(managedObject: NSManagedObject) {

		self.area = (managedObject.value(forKey: "area") as? Float)
		self.callingCode = (managedObject.value(forKey: "callingCode") as? String)
		self.code = (managedObject.value(forKey: "code") as? String)
		self.flag = (managedObject.value(forKey: "flag") as? String)
		self.id = (managedObject.value(forKey: "id") as? String)
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
		CDQueriesManager.shared.save(country: self)
	}

	func delete() {

		if !Thread.current.isMainThread {
			DispatchQueue.main.async {
				self.delete()
			}
			return
		}
		CDQueriesManager.shared.delete(country: self)
	}

    //MARK:- Model Identity
    var identityPredicate: NSPredicate {
        //TODO: Update identity predicate
    return NSPredicate.init(format: CountryModel.identityKey + " = %@", self.identityValue)

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