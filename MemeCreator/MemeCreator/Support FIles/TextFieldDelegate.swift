//
//  TextFieldDelegate.swift
//  MemeCreator
//
//  Created by Владислав Гнилозуб on 2/19/18.
//  Copyright © 2018 Владислав Гнилозуб. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject ,UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
