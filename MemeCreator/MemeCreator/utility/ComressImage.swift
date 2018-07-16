//
//  ComressImage.swift
//  MemeCreator
//
//  Created by Владислав Гнилозуб on 2/23/18.
//  Copyright © 2018 Владислав Гнилозуб. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func compressImage () -> UIImage {
        
        let actualHeight:CGFloat = self.size.height
        let actualWidth:CGFloat = self.size.width
        let imgRatio:CGFloat = actualWidth/actualHeight
        let maxWidth:CGFloat = 1024
        let resizedHeight:CGFloat = maxWidth/imgRatio
        let compressionQuality:CGFloat = 0.1
        
        let rect:CGRect = CGRect(x: 0, y: 0, width: maxWidth, height: resizedHeight)
        UIGraphicsBeginImageContext(rect.size)
        self.draw(in: rect)
        let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        let imageData:Data = UIImageJPEGRepresentation(img, compressionQuality)!
        UIGraphicsEndImageContext()
        
        return UIImage(data: imageData)!
        
    }
}
