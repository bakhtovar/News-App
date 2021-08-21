////
////  Extensions.swift
////  NewsAggregator
////
////  Created by Bakhtovar Umarov on 26/06/21.
////
//
//import Foundation
//import UIKit
//import Kingfisher
//
//
//
////extension UIImageView {
////    func loadImage(withUrl: String,  placeholderImage: UIImage? = nil) {
////        guard let url = URL(string: withUrl) else {
////            return
////        }
////        if let image = placeholderImage {
////                  self.image = image
////             } else {
////                 self.backgroundColor = .gray
////              }
////        DispatchQueue.global().async { [weak self] in
////            if let data = try? Data(contentsOf: url){
////                if let image = UIImage(data: data) {
////                    DispatchQueue.main.async {
////                        self?.image = image
////                        self?.backgroundColor = .clear
////                    }
////                }
////            }
////
////        }
////    }
////}
////
//
//
//extension UIImageView {
//    func loadImage(withUrl: String) {
//        guard let url = URL(string: withUrl) else {
//            return
//        }
//        let resource = ImageResource(downloadURL: url)
//        
//        let img = UIImageView.self
//        
////        img.kf.setImage(with: resource, placeholder: nil, options: , completionHandler: nil)
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url){
//                if let image = UIImage(data: data) {
//                
//                    DispatchQueue.main.async {
//                        self?.image = image
//                        
//                    }
//                    
//                }
//            }
//            
//        }
//    }
//}
