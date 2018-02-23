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
        fetchImage()
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
                            self.imageCollection.reloadData()
                        })
                    }
                })
            }
        })
    }

}

extension ImageCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.imageInCell.image = self.memes[indexPath.item].originalImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let createMemeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateMemeViewController") as! CreateMemeViewController
        present(createMemeVC, animated: true) {
            createMemeVC.imageView.image = self.memes[indexPath.item].originalImage.compressImage()
        }
    }
}
