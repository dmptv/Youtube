//
//  Extension.swift
//  Youtube
//
//  Created by Kanat A on 01/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: Float, green: Float, blue: Float) -> UIColor {
        return UIColor(colorLiteralRed: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
}


 let imageCashe = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    var imageUrlString: String?

    func loadImageUsingUrlString(urlString: String) {
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCashe = imageCashe.object(forKey: (urlString as NSString)) {
            
            DispatchQueue.main.async {
              self.image = imageFromCashe
            }
            
            return
        } 
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, responce, error) in
            
            if error != nil {
                print(error?.localizedDescription ?? 0)
            }
            
            if let unwrappedData = data {
            
            DispatchQueue.main.async {
                let imageToCashe = UIImage(data: unwrappedData)
                
                // чтобы в ячейку не приходила чужая картинка
                if self.imageUrlString == urlString {
                    imageCashe.setObject(imageToCashe!, forKey: urlString as NSString)
                }
                  
                self.image = imageToCashe
            }
            }
            
        }).resume()
    }
}











