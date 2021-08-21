//
//  News+CoreDataProperties.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//
//

import Foundation
import CoreData

struct ArticleCoreData: Codable {
   // let source: Source_
    let title: String?
    let url : String?
    let urlToImage: String?
    
}

extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }
    @NSManaged public var idButton: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var news: News?
    
    
    
    var allAtributes : ArticleCoreData {
            get {
                return ArticleCoreData(title: self.title, url: self.url, urlToImage: self.urlToImage)
            }
            set {
                self.title = newValue.title
                self.url = newValue.url
                self.urlToImage = newValue.urlToImage
               // self.sources?.name = newValue.source.name
            }
        }

}

extension News : Identifiable {

}
