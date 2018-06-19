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


class SignInVC: UIViewController {
    
    @IBOutlet var iknowPic: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        iknowPic.layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor
        iknowPic.layer.shadowOpacity = 0.8
        iknowPic.layer.shadowRadius = 5.0
        iknowPic.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        iknowPic.layer.cornerRadius = 4.0
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
                print("TUCK: Unable to authenticate with Firebase - \(error)")
            } else {
                print("TUCK: Successfully authenticated with Firebase")
            }
        }
    }
    
}













