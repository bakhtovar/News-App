//
//  SourceModel.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//
import Foundation

struct Sources: Codable {
    var sources: [SourceModel] 
}

struct SourceModel: Codable {
    let id: String?
    let name: String?
    let category: String?
}

