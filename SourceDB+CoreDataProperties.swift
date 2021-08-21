//
//  SourceDB+CoreDataProperties.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//
//

import Foundation
import CoreData


extension SourceDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SourceDB> {
        return NSFetchRequest<SourceDB>(entityName: "SourceDB")
    }

    @NSManaged public var category: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?

}

extension SourceDB : Identifiable {

}
