//
//  HomeViewController.swift
//  BookXpert
//
//  Created by Sree Lakshman on 16/04/25.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("HomeViewController loaded")

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

}
