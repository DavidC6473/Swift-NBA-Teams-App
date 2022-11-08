//
//  CoreDataEntity+CoreDataProperties.swift
//  IOS_A1_XML
//
//  Created by David Clarke on 18/04/2022.
//
//

import Foundation
import CoreData


extension CoreDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataEntity> {
        return NSFetchRequest<CoreDataEntity>(entityName: "CoreDataEntity")
    }

    @NSManaged public var abreviation: String?
    @NSManaged public var city: String?
    @NSManaged public var conference: String?
    @NSManaged public var division: String?
    @NSManaged public var dob: String?
    @NSManaged public var draft: String?
    @NSManaged public var height: String?
    @NSManaged public var logo: String?
    @NSManaged public var name: String?
    @NSManaged public var player: String?
    @NSManaged public var playerimage: String?
    @NSManaged public var playerweb: String?
    @NSManaged public var position: String?
    @NSManaged public var stadimage: String?
    @NSManaged public var stadium: String?
    @NSManaged public var webroster: String?
    @NSManaged public var webteam: String?
    @NSManaged public var isFavourited: Bool

}

extension CoreDataEntity : Identifiable {

}
