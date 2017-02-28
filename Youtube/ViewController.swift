//
//  ViewController.swift
//  Youtube
//
//  Created by Kanat A on 28/02/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        collectionView?.backgroundColor = .white
        
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellID" )
        
    }

 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as!  VideoCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

class VideoCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.image = UIImage(named: "Amanda")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let userProfileImageView: UIView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .purple
        return label
    }()
    
    let subtitleTextView: UITextView = {
    
        let textView = UITextView()
        textView.backgroundColor = .red
        return textView
    }()
  
    func addCustomConstrains() {
        
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        separateView.translatesAutoresizingMaskIntoConstraints = false
        userProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleTextView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            thumbnailImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            thumbnailImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            thumbnailImageView.bottomAnchor.constraint(equalTo: userProfileImageView.topAnchor, constant: -8),
            
            separateView.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor, constant: 16),
            separateView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separateView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separateView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separateView.heightAnchor.constraint(equalToConstant: 1),
            
            userProfileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            userProfileImageView.heightAnchor.constraint(equalToConstant: 44.0),
            userProfileImageView.widthAnchor.constraint(equalToConstant: 44.0),
            
            titleLabel.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: 0),
            
            subtitleTextView.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 8),
            subtitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleTextView.heightAnchor.constraint(equalToConstant: 20),
            subtitleTextView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 0)
    
            ])
    }
    
    func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separateView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        addCustomConstrains()
      }
    
}































