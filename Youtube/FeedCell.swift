//
//  FeedCell.swift
//  Youtube
//
//  Created by Kanat A on 05/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class FeedCell: BaseCell {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()

    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .brown
        
        addSubview(collectionView)
        
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
    }

}
