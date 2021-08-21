//
//  SignUpVC.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//

import UIKit
import Firebase

class SignUpVC: UIViewController, UITextFieldDelegate {
    //MARK: - IB OUTLETS
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameValue: UITextField!
    @IBOutlet weak var emailValue: UITextField!
    @IBOutlet weak var passwordValue: UITextField!
    @IBOutlet weak var registerText: UIButton!
    @IBOutlet weak var numberValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        hideKeyboardWhenTappedAround()
    }
    // MARK: - IB BUTTON SIGN UP
    @IBAction func registerButton(_ sender: Any) {
        signUp()
    }
    
    func configureItems() {
        registerText.layer.cornerRadius = 15
        nameValue.delegate = self
        emailValue.delegate = self
        passwordValue.delegate = self
        numberValue.delegate = self
    }
    
    //MARK: - ALERT
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Fill out the fields.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK:-SIGN UP
    func signUp (){
        let name = nameValue.text
        let password = passwordValue.text
        let email = emailValue.text
        let number = numberValue.text
        
        if (!name!.isEmpty && !password!.isEmpty && !email!.isEmpty && !number!.isEmpty ) {
            
            Auth.auth().createUser(withEmail: email ?? "", password: password ?? "") { (authResult, error) in
                if let e = error {
                    print(e.localizedDescription)
                    let alert = Service.createAlertController(title: "Error", message: e.localizedDescription)
                    self.present(alert, animated: true,completion: nil)
                } else {
                    if let res = authResult {
                        let ref  = Database.database().reference().child("users")
                        ref.child(res.user.uid).updateChildValues(["name" : name ?? "", "email": email ?? "", "number": number ?? ""])
                        
                    }
                }
            }
        }
        else {
            showAlert()
        }
    }
    //MARK: - HIDES KEYBOARD ON TAPPING BUTTON
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

