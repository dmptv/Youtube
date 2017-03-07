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
}


 let imageCashe = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    var imageUrlString: String?

    func loadImageUsingUrlString(urlString: String) {
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCashe = imageCashe.object(forKey: urlString as AnyObject) as? UIImage {
            
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
                    imageCashe.setObject(imageToCashe!, forKey: urlString as AnyObject)
                }
                  
                self.image = imageToCashe
            }
            }
            
        }).resume()
    }
}










