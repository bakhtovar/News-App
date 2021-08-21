//
//  SourcesData+CoreDataProperties.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//
//

import Foundation
import CoreData


extension SourcesData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SourcesData> {
        return NSFetchRequest<SourcesData>(entityName: "SourcesData")
    }

    @NSManaged public var name: String?
    @NSManaged public var news: News?

}

extension SourcesData : Identifiable {

}
