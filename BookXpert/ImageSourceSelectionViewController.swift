//
//  ImageSourceSelectionViewController.swift
//  BookXpert
//
//  Created by Sree Lakshman on 16/04/25.
//

import UIKit

class ImageSourceSelectionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var galleryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "placeholder")
    }
    
    @IBAction func openCamera(_ sender: UIButton) {
        openPicker(source: .camera)
    }
    
    @IBAction func openGallery(_ sender: UIButton) {
        openPicker(source: .photoLibrary)
    }
    
    private func openPicker(source: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(source) else {
            print("Source not available")
            return
        }
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = source
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    // MARK: - Image Picker Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            imageView.image = selectedImage
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

