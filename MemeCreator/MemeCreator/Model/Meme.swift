//
//  Meme.swift
//  MemeCreator
//
//  Created by Владислав Гнилозуб on 2/19/18.
//  Copyright © 2018 Владислав Гнилозуб. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    let topText: String?
    let buttonText: String?
    let originalImage: UIImage
    let memedImage: UIImage?
    
    
    init(originalImage: UIImage) {
        self.topText = nil
        self.buttonText = nil
        self.originalImage = originalImage
        self.memedImage = nil
    }
    
    init(topText: String, buttonText: String, originalImage: UIImage, memedImage: UIImage) {
        self.buttonText = buttonText
        self.topText = topText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
    
}
