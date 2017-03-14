//
//  Video.swift
//  Youtube
//
//  Created by Kanat A on 02/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class SafeJsonObject: NSObject {
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        // создаем строку из первой буквы и делаем ее uppercased
        let uppercasedFirstCharacter = String(describing: key.characters.first!).uppercased()
        
        // рэнж первой буквы
        let range = key.startIndex..<key.characters.index(key.startIndex, offsetBy: 1)
        
        // у key заменяем первую букву на ее uppercased
        let selectorString = key.replacingCharacters(in: range, with: uppercasedFirstCharacter)
        
//        let range = NSMakeRange(0, 1)
//        let selectorString = NSString(string: key).replacingCharacters(in: range, with: uppercasedFirstCharacter)
        
        // создаем селектор
        let selector = NSSelectorFromString("set\(selectorString):")
        
        // проверяем есть ли у self такой setter
        let respons = self.responds(to: selector)
        
        // так предотвратим краш если нет такого проперти
        if !respons {
            return
        }
        
        super.setValue(value, forKey: key)
    }
}

class Video: SafeJsonObject {
    
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: NSNumber?
    var uploadDate: NSDate?
    var duration: NSNumber?
    
    var channel: Channel?
    
    // переопределим метод родителя - SafeJsonObject
    override func setValue(_ value: Any?, forKey key: String) {
        
        if key == "channel" {
            
              // custom channel setup
            let channelDictionary = value as! [String: AnyObject]
            self.channel = Channel()
            self.channel?.setValuesForKeys(channelDictionary)

        } else {
            super.setValue(value, forKey: key)
        }
        
    }
    
    override init() {
        super.init()
    }
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
}

class Channel: SafeJsonObject {
    var name: String?
    var profile_image_name: String?
}















 
