//
//  SignUpVC.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//

import UIKit
import Firebase
import FirebaseAuth



class SignInVC: UIViewController, UITextFieldDelegate {
    
    //MARK: - IB OUTLETS
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailValue: UITextField!
    @IBOutlet weak var passwordValue: UITextField!
    @IBOutlet weak var loginText: UIButton!
    @IBOutlet weak var signupText: UIButton!
    
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureItems()
        hideKeyboardWhenTappedAround()
    }
    
    
    func configureItems(){
    loginText.layer.cornerRadius = 20
    signupText.layer.cornerRadius = 5
    emailValue.delegate = self
    passwordValue.delegate = self
    }
    //MARK: - HIDE NAV BAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK:- BUTTONS
    @IBAction func loginButton(_ sender: UIButton) {
    signIn()
    }
    @IBAction func signUpButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(identifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- ALERT
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Fill out the fields.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK:- SIGN IN WITH EMAIL AND PASSWORD
    func signIn() {
     
//        Auth.auth().signIn(withCustomToken: emailValue.text!) { (result, error) in
//            if let e = error {
//                print(e)
//                let alert = Service.createAlertController(title: "Error", message: e.localizedDescription)
//                self.present(alert, animated: true,completion: nil)
//            }
//            else {
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                let vc = storyboard.instantiateViewController(identifier: "main")
//                vc.modalPresentationStyle = .overFullScreen
//                self.present(vc, animated: true)
//            }
//        }
      //  Auth.auth().currentUser.linkWithCredential
        if let password = passwordValue.text, let email = emailValue.text {
            Auth.auth().signIn(withEmail: email, password: password  ) { [weak self] authResult, error in
                if let e = error {
                    print(e)
                    let alert = Service.createAlertController(title: "Error", message: e.localizedDescription)
                    self?.present(alert, animated: true,completion: nil)
                } else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(identifier: "main")
                    vc.modalPresentationStyle = .overFullScreen
                    self?.present(vc, animated: true)

                }
            }
        }
        
        
    }
    //MARK: - HIDES KEYBOARD ON TAPPING BUTTON
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
}


