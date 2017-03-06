//
//  SubscriptionsCell.swift
//  Youtube
//
//  Created by Kanat A on 06/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class SubscriptionsCell: FeedCell {

    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionsFeed { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

}
