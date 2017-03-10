//
//  SettingLauncher.swift
//  Youtube
//
//  Created by Kanat A on 03/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: SettingName
    let imageName: String
    
    init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingName: String {
    case Cancel = "Cancel & Dismiss Completely"
    case Setting = "Setting"
    case Terms = "Terms & privacy policy"
    case Feedback = "send feedback"
    case Help = "help"
    case Account = "Switch Account"
}

class SettingLauncher: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellID = "cellID"
    let cellHeight: CGFloat = 50
    
    // Data Source
    let settingsArray: [Setting] = {
        let setting = Setting(name: .Setting, imageName: "settings")
        
         return [setting, Setting(name: .Terms, imageName: "privacy"), Setting(name: .Feedback, imageName: "feedback"), Setting(name: .Help, imageName: "help"), Setting(name: .Account, imageName: "switch_account"), Setting(name: .Cancel, imageName: "cancel")]
    }()
    
    // homeVC как делегат
    var homeController: HomeController?
    
    //MARK: - Functions
    
    func showSettings() {
        if let window = UIApplication.shared.keyWindow {

            // полупрозрачное вью
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            blackView.frame =  window.frame
            blackView.alpha = 0
            
            let height: CGFloat = (CGFloat)(settingsArray.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                
            }, completion: nil)
        }
    }
    
    func handleDismiss(setting: Setting) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.width)
            }
            
        }) { (completion: Bool) in
            // goint to new VC
            if setting.name != .Cancel {
                self.homeController?.showControllerForSetting(setting: setting)
            }
        }
    }
    
    //MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let setting = self.settingsArray[indexPath.item]
        handleDismiss(setting: setting)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SettingCell
        cell.setting = settingsArray[indexPath.item]
        
        return cell
    }
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    override init() {
        super.init()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellID)
    }
    
   deinit {
        print("\(homeController) setting Launcher is being deinit")
    }
    
}














