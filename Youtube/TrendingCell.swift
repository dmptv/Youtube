//
//  TrendingCell.swift
//  Youtube
//
//  Created by Kanat A on 06/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
