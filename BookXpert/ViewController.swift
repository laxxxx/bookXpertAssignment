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
        
        // Check if a user is already signed in
        if let currentUser = Auth.auth().currentUser {
            print("User is already signed in with email: \(currentUser.email ?? "Unknown")")
            navigateToHomeViewController()
            
        } else {
            print("No user is signed in")
        }
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
                
                // Save the user details to Core Data
                if let firebaseUser = authResult?.user {
                    let uid = firebaseUser.uid
                    let email = firebaseUser.email ?? ""
                    let displayName = firebaseUser.displayName
                    CoreDataService.shared.saveUser(uid: uid, email: email, displayName: displayName)
                }
                
                // Navigate to the Home Screen after successful sign-in
                self.navigateToHomeViewController()
                
            }
        }
    }
    
    func navigateToHomeViewController() {
        guard let homeVC = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {
            print("Failed to instantiate HomeViewController")
            return
        }
        navigationController?.pushViewController(homeVC, animated: true)
    }
}
