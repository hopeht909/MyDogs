//
//  Dog+CoreDataProperties.swift
//  MyDogs
//
//  Created by admin on 24/05/1443 AH.
//
//

import Foundation
import CoreData


extension Dog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dog> {
        return NSFetchRequest<Dog>(entityName: "Dog")
    }

    @NSManaged public var dogColor: String?
    @NSManaged public var dogFavoriteTreat: String?
    @NSManaged public var dogImage: Data?
    @NSManaged public var dogName: String?

}

extension Dog : Identifiable {

}
