//
//  News+CoreDataProperties.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var idButton: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var sources: SourcesData?

}

extension News : Identifiable {

}
