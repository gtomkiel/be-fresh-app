//
//  UserEntity+CoreDataProperties.swift
//  coreData
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var password: String?
    @NSManaged public var email: String?
    @NSManaged public var firstName: String?
    @NSManaged public var secondName: String?

}

extension UserEntity : Identifiable {

}
