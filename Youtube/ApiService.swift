//
//  ApiService.swift
//  Youtube
//
//  Created by Kanat A on 05/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    let baseUrl = "https://api.myjson.com/bins" 
    
    func fetchVideos(completion: @escaping ([Video])->() ) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/ktfyn", completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video])->() ) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/tqy1b", completion: completion)
    }
    
    func fetchSubscriptionsFeed(completion: @escaping ([Video])->() ) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/1c9qnz", completion: completion)
    }
    
    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video])->() ) {
        
        if let url = URL(string: urlString) {
            
            URLSession.shared.dataTask(with: url) { (data, responce, error) in
                
                if error != nil {
                    print((error?.localizedDescription)! as String)
                    return
                }
                
                do {
                    if let unwrappedData = data,  let jsonDictionaries =  try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: AnyObject]] {

                        DispatchQueue.main.async {
                            completion(jsonDictionaries.map({return Video(dictionary: $0)}))
                        }
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
                }.resume()
        }
        
    }

}


//let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
//
//var videos = [Video]()
//
//for dictionary in json as! [[String: AnyObject]] {
//
//    let video = Video()
//    video.title = dictionary["title"] as? String
//    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//
//    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
//
//    let channel = Channel()
//    channel.name = channelDictionary["name"] as? String
//    channel.profileImageName = channelDictionary["profile_image_name"] as? String
//
//    video.channel = channel
//
//    videos.append(video)
//}
//
//dispatch_async(dispatch_get_main_queue(), {
//    completion(videos)
//})


                             // просто как пример
//                        let numbers = [1, 2, 3]
//                        let doublesNumbersArray = numbers.map({return $0 * 2})
//                        let stringsArray = numbers.map({return "\($0 * 2)"})
//                        print(stringsArray)

//                        var videos = [Video]()
//
//                        for dictionary in jsonDictionaries {
//                            let video = Video(dictionary: dictionary)
//                            videos.append(video)
//                        }





