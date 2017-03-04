//
//  SettingCell.swift
//  Youtube
//
//  Created by Kanat A on 04/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .darkGray : .white
            
            nameLabel.textColor = isHighlighted ? .white : .black
            
            iconImageView.tintColor = isHighlighted ? .white : .black
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name
            
            if let imageName = setting?.imageName {
                 // цвет картинки по умолчанию
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = .black
            }
            
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
          label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            nameLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor, constant: 0)
       
            ])
        
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        iconImageView.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: -8).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
 
    }
}













