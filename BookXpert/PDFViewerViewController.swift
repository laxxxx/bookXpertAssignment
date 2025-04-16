//
//  PDFViewerViewController.swift
//  BookXpert
//
//  Created by Sree Lakshman on 16/04/25.
//

import UIKit
import PDFKit

class PDFViewerViewController: UIViewController {
    
    var pdfURLString: String?
    private var pdfView: PDFView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupPDFView()
        setupCloseButton()
        loadRemotePDF()
    }
    
    private func setupPDFView() {
        pdfView = PDFView(frame: .zero)
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfView.autoScales = true
        view.addSubview(pdfView)
        
        NSLayoutConstraint.activate([
            pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pdfView.topAnchor.constraint(equalTo: view.topAnchor),
            pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupCloseButton() {
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("✕", for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        closeButton.tintColor = .black
        closeButton.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        closeButton.layer.cornerRadius = 20
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func loadRemotePDF() {
        guard let urlString = pdfURLString, let url = URL(string: urlString) else {
            print("Invalid PDF URL string")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading PDF: \(error.localizedDescription)")
                return
            }
            guard let data = data, let document = PDFDocument(data: data) else {
                print("Failed to load PDF data")
                return
            }
            DispatchQueue.main.async {
                self.pdfView.document = document
            }
        }.resume()
    }

    @objc func closeTapped() {
        dismiss(animated: true)
    }
}
