//
//  Bookmarks+CoreDataProperties.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//
//

import Foundation
import CoreData


extension Bookmarks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bookmarks> {
        return NSFetchRequest<Bookmarks>(entityName: "Bookmarks")
    }

    @NSManaged public var source: String?
    @NSManaged public var titleName: String?
    @NSManaged public var urlLink: String?
    @NSManaged public var urlToImage: String?

}

extension Bookmarks : Identifiable {

}
