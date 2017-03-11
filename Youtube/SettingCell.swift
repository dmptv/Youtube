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
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .darkGray : .white
            nameLabel.textColor = isSelected ? .white : .black
            iconImageView.tintColor = isSelected ? .white : .black
        }
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name.rawValue
            
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
     
        _ = iconImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nameLabel.leftAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: -8, widthConstant: 30, heightConstant: 30)
        
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
}














