//
//  HomeViewController.swift
//  BookXpert
//
//  Created by Sree Lakshman on 16/04/25.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var themeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HomeViewController loaded")
        themeSwitch.isOn = (Theme.current == .system)
        
    }
    
    @IBAction func themeSwitchChanged(_ sender: UISwitch) {
        let newTheme: Theme = sender.isOn ? .dark : .light
        Theme.current = newTheme
    }
    
    @IBAction func didTapViewPDF(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let pdfVC = storyboard.instantiateViewController(withIdentifier: "PDFViewerViewController") as? PDFViewerViewController else {
            return
        }
        
        pdfVC.pdfURLString = "https://fssservices.bookxpert.co/GeneratedPDF/Companies/nadc/2024-2025/BalanceSheet.pdf"
        pdfVC.modalPresentationStyle = .fullScreen
        present(pdfVC, animated: true, completion: nil)
    }
    
    @IBAction func didTapViewImage(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let imageVC = storyboard.instantiateViewController(withIdentifier: "ImageSourceSelectionViewController") as? ImageSourceSelectionViewController {
            present(imageVC, animated: true)
        }
    }
    
    @IBAction func didTapAPICoreData(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let imageVC = storyboard.instantiateViewController(withIdentifier: "ProductViewController") as? ProductViewController {
            present(imageVC, animated: true)
        }
    }
    
    @IBAction func didTapLogout(_ sender: UIButton) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { _ in
            self.performLogout()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func performLogout() {
        do {
            // Firebase sign out
            try Auth.auth().signOut()
            
            // Google sign out
            GIDSignIn.sharedInstance.signOut()
            
            // Navigate to login screen (root view controller)
            if let navController = self.navigationController {
                navController.popToRootViewController(animated: true)
            } else {
                // Fallback in case HomeVC was presented modally
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let loginVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                    loginVC.modalPresentationStyle = .fullScreen
                    present(loginVC, animated: true, completion: nil)
                }
            }
            
        } catch let signOutError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}
