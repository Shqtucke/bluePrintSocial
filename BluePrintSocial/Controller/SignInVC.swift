//
//  ViewController.swift
//  BluePrintSocial
//
//  Created by Shaun Tucker on 6/17/18.
//  Copyright © 2018 Shaun Tucker. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var iknowPic: UIImageView!
    
    @IBOutlet var emailField: FancyText!
    @IBOutlet var pwdField: FancyText!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
        iknowPic.layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor
        iknowPic.layer.shadowOpacity = 0.8
        iknowPic.layer.shadowRadius = 5.0
        iknowPic.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        iknowPic.layer.cornerRadius = 4.0
        
        self.pwdField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "gotoFeed", sender: nil)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailField.resignFirstResponder()
        pwdField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("TUCK: Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("TUCK: user cancelled Facebook Authentication")
            } else {
                print("TUCk: Successfully authentication with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("TUCK: Unable to authenticate with Firebase - \(String(describing: error))")
                
            } else {
                print("TUCK: Successfully authenticated with Firebase")
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
            }
        }
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let pwd = pwdField.text {
            Auth.auth().signIn(withEmail: email, password: pwd) { (user, error) in
                if error == nil {
                    print("TUCK: Email user authenticated with Firebase")
                    if let user = user {
                        self.completeSignIn(id: user.uid)
                    }
                    
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("TUCK: Unable to authenticate with Firebase using email")
                        } else {
                            print("TUCK: Successfully authenticated")
                            if let user = user {
                                self.completeSignIn(id: user.uid)
                            }
                            
                        }
                    })
                  
                    
                }
                }
            }
        }
    
    func completeSignIn(id: String) {
       let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("TUCK: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "gotoFeed", sender: nil)
    }

}















