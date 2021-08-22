//
//  Constans.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//

import Foundation
import UIKit

struct K {
    static let APIKey = "ENTER_YOUR_KEY" // MARK: - ENTER HERE YOUR NEWS API KEY
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

