//
//  ImagesCollectionViewController.swift
//  TestWithings
//
//  Created by Mathis Fouques on 26/11/2021.
//

import UIKit

class ImagesCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchBar = UISearchBar()

    private var photos = [PixabayImage]()
    private let reuseIdentifier = "ImageCell"
    
    override func viewDidLoad() {
        
    }
}

// MARK: - UICollectionViewDataSource

extension ImagesCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageCell
        
        let photo = photos[indexPath.item]
        cell.imageId = photo.id
        cell.imageView.image = photo.thumbnailImage
        
        if photo.thumbnailImage == nil {
            DispatchQueue.global(qos: .userInitiated).async {
                guard
                    let imageData = try? Data(contentsOf: photo.thumbnailURL),
                    let image = UIImage(data: imageData) else {
                        return
                }
       
                photo.thumbnailImage = image
                
                if cell.imageId == photo.id {
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                    }
                }
            }
        }
        
        return cell
    }
}
