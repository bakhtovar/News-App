// DBModel.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//
import Foundation
import UIKit
import CoreData
class CategoryDBModel: NSManagedObject {
    
    

    @NSManaged var articeModel: [ArticleDBModel]
    
    func saveUserData(art: ArticleDBModel ) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        let newArticle = NSEntityDescription.insertNewObject(forEntityName: "News", into: context) as NSManagedObject
        newArticle.setValue(art.urlToImage, forKey: "urlToImage")
        newArticle.setValue(art.idButton, forKey: "idButton")
        newArticle.setValue(art.url, forKey: "url")
        newArticle.setValue(art.name, forKey: "name")
        newArticle.setValue(art.title, forKey: "title")
        
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving: \(error)")
        }
        
    }
    
}

class ArticleDBModel: NSManagedObject {
    @NSManaged public var url: String?
    @NSManaged public var urlToImage: String?
    @NSManaged public var title: String?
    @NSManaged public var name: String?
    @NSManaged public var idButton: String?
}


class SourcesDBModel: NSManagedObject {
    
    @NSManaged var sourceModel: [SourceDBModel]
    
    
    func saveSourceData(_ id:String, name:String, category:String) {
      let context = (UIApplication.shared.delegate as!
              AppDelegate).persistentContainer.viewContext
        let newArticle = NSEntityDescription.insertNewObject(forEntityName: "SourceDB", into: context)
        newArticle.setValue(id, forKey: "id")
        newArticle.setValue(name, forKey: "name")
        newArticle.setValue(category, forKey: "category")
        
        do {
             try context.save()
             print("Success")
           } catch {
            print("Errorr: \(error.localizedDescription)")
           }
         }
//    func fetch() {
//       let appDelegate = UIApplication.shared.delegate as! AppDelegate
//       let context = appDelegate.persistentContainer.viewContext
//       let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "SourceDB")
//       do {
//        let result = try context.fetch(fetch)
//        for data in result as! [NSManagedObject] {
//         print(data.value(forKey: "name") as! String)
//        }
//       } catch {
//        print("Failed")
//       }
//     }
}


class SourceDBModel: NSManagedObject {
    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var category: String?
}






















//    func saveUserData(_ articles: [News]) {
//        let context = (UIApplication.shared.delegate as!
//                AppDelegate).persistentContainer.viewContext
//        for article in articles {
//                let newArticle = NSEntityDescription.insertNewObject(forEntityName: "News", into: context)
//            newArticle.setValue(article.idButton, forKey: "idButton")
//            newArticle.setValue(article.imageUrl, forKey: "imageUrl")
//            newArticle.setValue(article.linkUrl, forKey: "linkUrl")
//            newArticle.setValue(article.sourceName, forKey: "sourceName")
//            newArticle.setValue(article.titleName, forKey: "titleName")
//            }
//            do {
//                try context.save()
//                print("Success")
//            } catch {
//                print("Error saving: \(error)")
//            }
//}
