//
//  ResetVC.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//

import UIKit
import Firebase
class ResetVC: UIViewController, UITextFieldDelegate {
    
    //MARK: - IB OUTLETS
    @IBOutlet weak var resetTitle: UILabel!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var resetText: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailLabel.delegate = self
        resetText.layer.cornerRadius = 10
    }
    
    func textFieldShouldReturn(_ emailLabel: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
        
    }

    //MARK:- RESET TAPPING
    @IBAction func resetTapped(_ sender: Any) {
        let auth = Auth.auth()
        auth.sendPasswordReset(withEmail: emailLabel.text ?? "") { (error) in
            if let error = error {
                let alert = Service.createAlertController(title: "Error", message: error.localizedDescription)
                self.present(alert, animated: true,completion: nil)
                
                return
            }
            let alert = Service.createAlertController(title: "Done", message: "A password has been sent to your email.")
            self.present(alert, animated: true,completion: nil)
        }
    }
    
}
