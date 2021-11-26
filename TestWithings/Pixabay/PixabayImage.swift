//
//  PixabayImage.swift
//  TestWithings
//
//  Created by Mathis Fouques on 26/11/2021.
//

import UIKit

class PixabayImage {
    let id: Int
    let thumbnailURL: URL
    let largeImageURL: URL
    var thumbnailImage: UIImage?
    var largeImage: UIImage?
    
    init(id: Int, thumbnailURL: URL, largeImageURL: URL) {
        self.id = id
        self.thumbnailURL = thumbnailURL
        self.largeImageURL = largeImageURL
    }
}
