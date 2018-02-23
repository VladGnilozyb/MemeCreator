//
//  CreateMemeViewController.swift
//  MemeCreator
//
//  Created by Владислав Гнилозуб on 2/23/18.
//  Copyright © 2018 Владислав Гнилозуб. All rights reserved.
//

import UIKit

class CreateMemeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var generateButton: UIBarButtonItem!
    @IBOutlet weak var conteinerImageAndText: UIView!
    private var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: Work With UiPickerController
    
    @IBAction func openCamera(_ sender: UIBarButtonItem) {
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerControllerSourceType.camera
        picker.cameraCaptureMode = .photo
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func openPhotoLibrary(_ sender: UIBarButtonItem) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
}

extension CreateMemeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.imageView.image = image?.compressImage()
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
