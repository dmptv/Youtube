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
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: (navigationController?.navigationBar.frame.width)! - 32, height: (navigationController?.navigationBar.frame.height)!))
        label.text = "Home"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = label
        
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView?.backgroundColor = .white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellID" )
        
    }
    
 
    
    //MARK: - UICollectionViewDelegateFlowLayout
 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as!  VideoCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.size.width - 16 - 16) * 9 / 16
        
        return CGSize(width: view.frame.size.width, height: height + 16 + 68)
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
        imageView.image = UIImage(named: "Amanda")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let separateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(colorLiteralRed: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let userProfileImageView: UIView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Amanda1")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Amanda Cerny - Alissa Violet"
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "AmandaCerny ⍣ 1,747,874,900 views ✦ 2 years ago Amanda Cerny Sexy"
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.textColor = .lightGray
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
            
            subtitleTextView.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 4),
            subtitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleTextView.heightAnchor.constraint(equalToConstant: 30),
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































