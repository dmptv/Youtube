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
    
    let cellID = "cellID"
    
    func fetchVideos() {
        // pars json
        ApiService.sharedInstance.fetchVideos { (videos: [Video]) in
            self.videos = videos
            self.collectionView?.reloadData()
        }
    }
    
    //MARK: -  Вместо подписок на протокол 
    
    // чтобы settingLauncher исп homeController как делегат
    lazy var settingLauncher: SettingLauncher = {
        let launcher = SettingLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    // чтобы menuBar исп homeController как делегат
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        mb.homeController = self
        return mb
    }()
    
    //View Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: (navigationController?.navigationBar.frame.width)! - 32, height: (navigationController?.navigationBar.frame.height)!))
        titleLabel.text = " Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        navigationItem.titleView = titleLabel
        
        navigationController?.navigationBar.isTranslucent = false

        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
    }
    
    fileprivate func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = .white
        //collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellID" )
//        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.isPagingEnabled = true
    }
    
    fileprivate func setupNavBarButtons() {
        // alwaysOriginal - чтобы картинка была цветной
        
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButton,  searchBarButtonItem]
    }
    
    // Handles
    func handleMore() {
        // show menu
        settingLauncher.showSettings()
    }
    
    
    // здесь HomeVC как делегат вызывает функцию по запросу settingLauncher
    
    func showControllerForSetting(setting: Setting) {
        
        let dummyVc = UIViewController()
        dummyVc.navigationItem.title = setting.name.rawValue
        dummyVc.view.backgroundColor = .white
        
        // back - сделаем белым тк у нав бар .alwaysTemplate
        navigationController?.navigationBar.tintColor = .white
        // сменим  цвет title
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        navigationController?.pushViewController(dummyVc, animated: true)
    }

    func handleSearch() {
        
    }
    
    // здесь HomeVC как делегат вызывает функцию по запросу menuBar
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        // при свайпе меняем item по indexPath
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    fileprivate func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        redView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(redView)
        NSLayoutConstraint.activate([
            redView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            redView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            redView.heightAnchor.constraint(equalToConstant: 50),
            redView.topAnchor.constraint(equalTo: view.topAnchor)
            ])

        view.addSubview(menuBar)
        NSLayoutConstraint.activate([
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: 50)
            ])
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // чтобы horizontalBarView смещалась когда свайпаем вьюшки 
        menuBar.horizontalLeftAnchor?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let indexPath = IndexPath(item: Int(index), section: 0)
        
        // чтобы подсвечивались items в menuBar
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
 
    //MARK: - UICollectionViewDataSource
 
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return videos?.count ?? 0
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as!  VideoCell
//        cell.video = videos?[indexPath.item]
//        return cell
//    }
//    
//    //MARK: - UICollectionViewDelegateFlowLayout
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (view.frame.size.width - 16 - 16) * 9 / 16
//        return CGSize(width: view.frame.size.width, height: height + 16 + 88)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        DispatchQueue.main.async {
//            self.collectionView?.collectionViewLayout.invalidateLayout()
//        }
//    }

    deinit {
        print("\(settingLauncher) homeVC is being deinit")
    }
 
    
}
































