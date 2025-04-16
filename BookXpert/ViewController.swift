//
//  ViewController.swift
//  BookXpert
//
//  Created by Sree Lakshman on 15/04/25.
//

import UIKit
import GoogleSignIn
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var signInWithGoogleBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view loaded")
    }
    
    
    @IBAction func didTapSignInWithGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { authentication, error in
            if let error = error {
                print("There is an error signing the user in ==> \(error)")
                return
            }
            
            guard let user = authentication?.user, let idToken = user.idToken?.tokenString else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("There is an error signing the user in ==> \(error)")
                    return
                }
                
                print("User signed in successfully \(authResult?.user.email ?? "____")")
                
            }
        }
        
    }
}
