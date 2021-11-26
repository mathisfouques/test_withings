//
//  ImageFlowLayout.swift
//  TestWithings
//
//  Created by Mathis Fouques on 26/11/2021.
//

import UIKit

class ImageFlowLayout: UICollectionViewFlowLayout {
    private let minColumnWidth: CGFloat = 120.0
    private let paddingSize: CGFloat = 1.0
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = self.collectionView else { return }
    
        self.minimumLineSpacing = paddingSize
        self.minimumInteritemSpacing = paddingSize
        
        self.sectionInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        self.sectionInsetReference = .fromSafeArea
        
        let availableWidth = collectionView.bounds.inset(by: collectionView.safeAreaInsets).width
        let maxNumColumns = (availableWidth / minColumnWidth).rounded(.down)
        let totalPaddingWidth = paddingSize * (maxNumColumns - 1) + self.sectionInset.left + self.sectionInset.right
        let sideLength = ((availableWidth - totalPaddingWidth) / maxNumColumns).rounded(.down)
        
        self.itemSize = CGSize(width: sideLength, height: sideLength)
    }
}
