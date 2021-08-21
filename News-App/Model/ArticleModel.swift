//
//  ArticleModel.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//

import Foundation
import UIKit

struct Articles: Codable {
    var articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String?
    let url : String?
    let urlToImage: String?
    
}

struct Source: Codable {
    let name: String?
}



