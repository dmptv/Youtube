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
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion: @escaping ([Video])->() ) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/home_num_likes.json", completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video])->() ) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionsFeed(completion: @escaping ([Video])->() ) {
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video])->()) {
        
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





