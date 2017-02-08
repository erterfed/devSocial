//
//  ViewController.swift
//  devSocial
//
//  Created by erterfed on 30/1/17.
//  Copyright © 2017 erterfed. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func facebookBtnTapped(_ sender: AnyObject) {
        
        //using Facebook Manager to first check for authentication against Facebook
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("ert: Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                //maybe user doesnt want to share email so he can choose to cancel
                print("ert: User cancel Facebook authentication")
            } else {
                print("ert: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)   
            }
        }
        
    }
    
    /*
    @IBAction func facebookBtnTapped(_ sender: AnyObject) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("ert: Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("ert: User cancelled Facebook authentication")
            } else {
                print("ert: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
        
    }*/
    
    
    //Firebase authentication using Facebook's credential
    //so that users can use Facebook's login to also log into Firebase for their data stored in Firebase
    func firebaseAuth(_ credential: FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("ert: Unable to authenticate with Firebase -  \(error)")
            } else {
                print("ert: Successfully authenticate with Firebase")
                /*
                if let user = user {
                    KeychainWrapper.standard.set(user?.uid, forKey: KEY_UID)
                }
                */
            }
        })
    }
 
    /*
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("JESS: Unable to authenticate with Firebase - \(error)")
            } else {
                print("JESS: Successfully authenticated with Firebase")
                /*if let user = user {
                    let userData = ["provider": credential.provider]
                    self.completeSignIn(id: user.uid, userData: userData)
                }*/
            }
        })
    }
    */
    
    
    @IBAction func signInTapped(_ sender: AnyObject) {
        if let email = emailField.text, let pwd = pwdField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print ("ert: Email user authenticated with Firebase")
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("ert: Unable to authenticate with Firebase using email")
                        } else {
                            print("ert: Successfully authenticated with Firebase")
                        }
                    })
                }
            })
        }
    }
    
    
}

