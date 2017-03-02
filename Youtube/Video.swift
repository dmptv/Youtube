//
//  Video.swift
//  Youtube
//
//  Created by Kanat A on 02/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class Video: NSObject {
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}
