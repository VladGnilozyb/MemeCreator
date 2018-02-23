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
    private var meme: Meme!
    private var textFieldDelegate: TextFieldDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.textAlignment = .center
        bottomTextField.textAlignment = .center
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        imageView.backgroundColor = UIColor.black
        topTextField.delegate = textFieldDelegate
        bottomTextField.delegate = textFieldDelegate
        picker.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    //MARK: work with keyboard
    
    @objc func keyboardWillShow(_ notification:Notification) {
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    //MARK: work with creating meme
    func generateMemedImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: imageView.bounds.size)
        let image = renderer.image { ctx in
            conteinerImageAndText.drawHierarchy(in: imageView.bounds, afterScreenUpdates: true)
        }
        return image
    }
    
    func saveMeme() {
        let memedImage = generateMemedImage()
        meme = Meme(topText: topTextField.text!, buttonText: bottomTextField.text!, originalImage: imageView.image!, memedImage: memedImage)
    }
    
    @IBAction func shareMeme(_ sender: UIBarButtonItem) {
        let memeImage = generateMemedImage()
        let myActivityView = UIActivityViewController(activityItems: [memeImage], applicationActivities: nil)
        present(myActivityView, animated: true, completion: nil)
        myActivityView.completionWithItemsHandler = {
            (activity, success, items, error) in
            if success {
                self.saveMeme()
                self.dismiss(animated: true, completion: nil)
            }
        }
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
