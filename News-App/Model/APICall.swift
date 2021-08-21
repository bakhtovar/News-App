//
//  APIAdapter.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//

import Foundation
import UIKit

class APICall {
    static let shared = APICall()
    let session = URLSession.shared
    
    init() {}
    
    func fetchData(category: PassUrl, completion:  @escaping (_ article: Articles ) -> Void )  {
        var url: URL?
        
        let urlCat = URL(string: "\(K.url)top-headlines?country=us&page=\(category.pageInt)&category=\(category.categoryName?.lowercased() ?? "")&apiKey=\(K.APIKey)")
        
        guard let urlSource = URL(string: "https://newsapi.org/v2/top-headlines?sources=\(category.id ?? "")&apiKey=\(K.APIKey)") else {return}
        
        guard let urlSearch = URL(string: "\(K.url)everything?q=\(category.searchText?.lowercased() ?? "" )&page=\(category.pageInt)&apiKey=\(K.APIKey)") else {return}
        
        //MARK: - CHECHKING URL
        if category.categoryName != "" && category.id == nil {
            url = urlCat
        } else if category.id != nil {
            url = urlSource
        } else if category.categoryName == "" && category.id == nil {
            url = urlSearch
        }
        if let url = url {
            let task = session.dataTask(with: url) { (data, respone, error) in
                if error == nil && data != nil {
                    do {
                        let result = try JSONDecoder().decode(Articles.self, from: data!)
                        completion(result)
                        print(url)
                    }
                    catch {
                        print("Error. Try Again")
                    }
                    
                }
            }
            task.resume()
            
        }
    }
    
    func getSources(completion:  @escaping (_ sources: Sources ) -> Void) {
        
        guard let url = URL(string: "\(K.url)sources?country=us&apiKey=\(K.APIKey)") else {
            return
        }
        
        let task = session.dataTask(with: url){ (data, response, error) in
            if error == nil && data != nil {
                do {
                    let result = try JSONDecoder().decode(Sources.self, from: data!)
                    completion(result)
                }
                catch {
                    print("Error on fetching sources")
                }
            }
        }
        task.resume()
    }
}

