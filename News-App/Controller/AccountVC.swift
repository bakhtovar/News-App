//
//  AccountVC.swift
//  News-App
//
//  Created by Bakhtovar Umarov on 21/08/21.
//

import UIKit
import Firebase
import SwiftGifOrigin


class AccountVC: UIViewController {
    
   //MARK: -  REFERING TO DATABASE
    var ref = Database.database().reference(fromURL: "news-acae1-default-rtdb.firebaseio.com/")
    var currentName : String?
    
    //MARK: - IB OUTLETS
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        avatarImage.image = UIImage.gif(name: "avatar")
        loadUserData()
     
    }
    
    func loadUserData() {
        guard let uid  = Auth.auth().currentUser?.uid else {
            return
        }
        
        let databaseRef = Database.database().reference()
        databaseRef.child("users").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
            
            if snapshot.hasChild(self.phoneLabel.text!){
                print("exist")
             }else{
                 print("does not exist")
             }
         })

        
        Database.database().reference().child("users").child(uid).child("name").observeSingleEvent(of: .value) { (snapshot) in
            guard let name = snapshot.value as? String else { return }
            self.userName.text = "Hi, \(name)"
            UIView.animate(withDuration: 0.5) {
                self.userName.alpha = 1
            }
        }
        
        Database.database().reference().child("users").child(uid).child("number").observeSingleEvent(of: .value) { (snapshot) in
            guard let number = snapshot.value as? String else { return }
            self.phoneLabel.text = "Your numbers are \(number)"
            UIView.animate(withDuration: 0.5) {
                self.userName.alpha = 1
            }
        }
        
    }

    //MARK: - LOG OUT
    @IBAction func logOutPressed(_ sender: Any) {
        tabBarController?.tabBar.isHidden = true
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }    
}
