//
//  Service.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//

import Foundation
import UIKit

class Service {
      static func createAlertController(title: String, message: String) -> UIAlertController {
          let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
          
          let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
              alert.dismiss(animated: true, completion: nil)
          }
          
          alert.addAction(okAction)
          
          return alert
      }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
