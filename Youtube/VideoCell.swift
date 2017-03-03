//
//  VideoCell.swift
//  Youtube
//
//  Created by Kanat A on 01/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit


class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class VideoCell: BaseCell {

    //MARK: - Properties
    
    var heightTitle: CGFloat = 20
    
    var video: Video? {
        didSet {
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            setupProfileImage()
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews {
                let subtitletext = "\(channelName) ◆ \(numberFormatter.string(from: numberOfViews)!) ◆ 2 years ago"
                subtitleTextView.text = subtitletext
            }
        
            // measure title text
            if let title = video?.title {
                
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesLineFragmentOrigin.union(.usesFontLeading)
                
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect.size.height > 20  {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
            
        }
    }
    
    func setupProfileImage() {
        if let profileImageUrl = video?.channel?.profileImageName {
             userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
        }
        
    }
    
    func setupThumbnailImage() {
        if let tnumbnailImageUrl = video?.thumbnailImageName {
            thumbnailImageView.loadImageUsingUrlString(urlString: tnumbnailImageUrl)
        }
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
    
    let userProfileImageView: UIImageView = {
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
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.allowsDefaultTighteningForTruncation = true
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "AmandaCerny ⍣ 1,747,874,900 views ✦ 2 years ago Amanda Cerny Sexy"
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.textColor = .lightGray
        return textView
    }()
    
     var titleLabelHeightConstraint: NSLayoutConstraint?
    
    //MARK:- Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            
            separateView.topAnchor.constraint(equalTo: userProfileImageView.bottomAnchor, constant: 36),
            separateView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separateView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separateView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separateView.heightAnchor.constraint(equalToConstant: 1),
            
            userProfileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            userProfileImageView.heightAnchor.constraint(equalToConstant: 44.0),
            userProfileImageView.widthAnchor.constraint(equalToConstant: 44.0),
            
            titleLabel.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: 0),
            
            subtitleTextView.leadingAnchor.constraint(equalTo: userProfileImageView.trailingAnchor, constant: 4),
            subtitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleTextView.heightAnchor.constraint(equalToConstant: 30),
            subtitleTextView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 0)
            ])
        
       titleLabelHeightConstraint = titleLabel.heightAnchor.constraint(equalToConstant: 20)
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(thumbnailImageView)
        addSubview(separateView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        addCustomConstrains()
    }
    
}
