//
//  Constans.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//

import Foundation
import UIKit

struct K {
   //static let APIKey = "2e98cd9cf2274ad28b71698fafe89c12"
   //static let APIKey = "e0154366766d416891b915552e9a4578"
   // static let APIKey = "dce1a396b5ba40b19317b9be747a3d4c"
   static let APIKey = "068d0bb8e68442748294d69dbef71e6f"
    
    static let url = "https://newsapi.org/v2/"
    var total = 4
    var totalPage = 19
    var generalURL = "https://newsapi.org/v2/top-headlines?country=us&category=general&apiKey=\(APIKey)"
    var businessURL = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=\(APIKey)"
    var scienceURL = "https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=\(APIKey)"
    var techURL = "https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=\(APIKey)"
    var healthURL = "https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=\(APIKey)"
    var entertainmentURL = "https://newsapi.org/v2/top-headlines?country=us&category=entertainment&apiKey=\(APIKey)"
    var sportsURL = "https://newsapi.org/v2/top-headlines?country=us&category=sports&apiKey=\(APIKey)"

}

