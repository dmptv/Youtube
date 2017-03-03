//
//  ViewController.swift
//  Youtube
//
//  Created by Kanat A on 28/02/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video]?
    
    func fetchVideos() {
        
        // pars json
        
        if let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json") {
            URLSession.shared.dataTask(with: url) { (data, responce, error) in
                
                if error != nil {
                    print((error?.localizedDescription)! as String)
                    return
                }
                
                do {
                    let json =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                    
                    self.videos = [Video]()
                    
                    for dictionary in json as! [[String: AnyObject]] {
                        
                        let video = Video()
                        video.title = dictionary["title"] as? String
                        video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                        
                        let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                        
                        let channel = Channel()
                        channel.name = channelDictionary["name"] as? String
                        channel.profileImageName = channelDictionary["profile_image_name"] as? String
                        
                        video.channel = channel
                        
                        self.videos?.append(video)
                                                
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                        
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
                
                
                }.resume()
        }
    }
    
    //View Life Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: (navigationController?.navigationBar.frame.width)! - 32, height: (navigationController?.navigationBar.frame.height)!))
        label.text = "Home"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        
        navigationItem.titleView = label
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView?.backgroundColor = .white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellID" )
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        setupMenuBar()
        setupNavBarButtons()
    }
    
    //MARK: - Setup Bars
    
    fileprivate func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButton,  searchBarButtonItem]
    }
    
    func handleMore() {
        print(123)
    }
    
    func handleSearch() {
        print(123)
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    fileprivate func setupMenuBar() {
        view.addSubview(menuBar)
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.topAnchor.constraint(equalTo: view.topAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
 
    
    //MARK: - UICollectionViewDataSource
 
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as!  VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.size.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.size.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
   

    
}
































