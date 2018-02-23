//
//  ImageCollectionViewController.swift
//  MemeCreator
//
//  Created by Владислав Гнилозуб on 2/23/18.
//  Copyright © 2018 Владислав Гнилозуб. All rights reserved.
//

import UIKit
import Firebase

class ImageCollectionViewController: UIViewController {
    private var memes = [Meme]()
    @IBOutlet weak var imageCollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchImage() {
        Database.database().reference().child("meme").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                print(dictionary["image"] as! String)
                Storage.storage().reference(forURL: dictionary["image"] as! String).getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
                    if error != nil {
                        print("**** Error, can'not dowland image because \(String(describing: error))")
                    } else {
                        DispatchQueue.main.async(execute: {
                            let originalImage = Meme(originalImage: UIImage(data: data!)!)
                            self.memes.insert(originalImage, at: 0)
                        })
                    }
                })
            }
        })
    }


    
}
