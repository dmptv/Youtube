//
//  ViewController.swift
//  Youtube
//
//  Created by Kanat A on 28/02/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
 
    let cellID = "cellID"
    let trendingCellID = "trendingCellID"
    let subscriptionsCellID = "subscriptionsCellID"
    
    var indexPathByTap: IndexPath?
    var indexPathByScroll: IndexPath?
    
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    
    lazy var settingLauncher: SettingLauncher = {
        let launcher = SettingLauncher()
        weak var weakSelf = self
        launcher.homeController = weakSelf
        return launcher
    }()
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        weak var weakSelf = self
        mb.homeController = weakSelf
        return mb
    }()
    
    //MARK: - View Life Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
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
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellID)
        collectionView?.register(SubscriptionsCell.self, forCellWithReuseIdentifier: subscriptionsCellID)
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.isPagingEnabled = true
    }
    
    fileprivate func setupNavBarButtons() {
        
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButton,  searchBarButtonItem]
    }
    
    //MARK: - Handles
    
    func handleMore() {
        // show menu
        settingLauncher.showSettings()
    }
    
    func handleSearch() {
        
    }
    
    // for settingLauncher
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

    // for menuBar
    func scrollToMenuIndex(menuIndex: Int) {
        
        // при тапе в menuBar меняем item по indexPath
        let indexPath = IndexPath(item: menuIndex, section: 0)
        indexPathByTap = indexPath
        indexPathByScroll = nil
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
        
        setTitleForIndex(index: menuIndex)
    }
    
    fileprivate func setTitleForIndex(index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = " \(titles[index])"
        }
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
    
    //MARK: - UIScrollViewDelegate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // чтобы horizontalBarView смещалась когда свайпаем вьюшки
        menuBar.horizontalLeftAnchor?.constant = scrollView.contentOffset.x / 4
    }

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // делим 800 на 200 = получим индекс
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        indexPathByScroll = indexPath
        indexPathByTap = nil
        
        // чтобы подсвечивались items в menuBar
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
  
        setTitleForIndex(index: Int(index))
    }
    
    //MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // data source передается в самих cell
        let identifier: String
        
        if indexPath.item == 1 {
            identifier = trendingCellID
        } else if indexPath.item == 2   {
            identifier = subscriptionsCellID
        } else {
            identifier = cellID 
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        return cell
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }

    deinit {
        print("\(settingLauncher) homeVC is being deinit")
    }
    
    //MARK: - Device Orientation
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateCollectionViewLayout(with: size)
    }

    private func updateCollectionViewLayout(with size: CGSize) {
        
        // для примера
        let itemSizeForPortraitMode = CGSize(width: view.frame.width, height: view.frame.height - 50)
        let itemSizeForLandscapeMode = CGSize(width: view.frame.width, height: view.frame.height - 50)
        
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = ((size.width < size.height) ? itemSizeForPortraitMode : itemSizeForLandscapeMode)
            layout.invalidateLayout()
        }
        
        DispatchQueue.main.async {
            var indexToItem = IndexPath()
            
            // we've got index after tap or scroll
            if let indTap = self.indexPathByTap {
                indexToItem = indTap
            } else if let indScroll = self.indexPathByScroll {
                indexToItem = indScroll
            } else {
                return
            }

            self.collectionView?.scrollToItem(at: indexToItem, at: .centeredHorizontally, animated: true)
            self.collectionView?.reloadData()
        }
      
    }
}



