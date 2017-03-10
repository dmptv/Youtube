//
//  VideoLauncher.swift
//  Youtube
//
//  Created by Kanat A on 07/03/2017.
//  Copyright © 2017 ak. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let avi = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        avi.translatesAutoresizingMaskIntoConstraints = false
        avi.startAnimating()
        return avi
    }()
    
    let pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    var isPlaying = false
    
    // пауза или play
    func handlePause() {
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play" ), for: .normal)
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause" ), for: .normal)
        }
        
        isPlaying = !isPlaying
    }
    
    // container view для элементов контрола
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 13)
        return label
        
    }()
    
    let videoSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    // прикрутим слайдер к видео
    func handleSliderChange() {
        
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            // высчитаем соотношение слайдера и длины видео
            let value = Float64(videoSlider.value) * totalSeconds
            
            // создадим время видео
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            
            // прокручиваем видео
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                
            })
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
        setupGradientLayer()
        
        // чтобы controlsContainerView был выше добавим его после плэейра
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        NSLayoutConstraint.activate([
            pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            pausePlayButton.widthAnchor.constraint(equalToConstant: 50),
            pausePlayButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        
        controlsContainerView.addSubview(videoLengthLabel)
        NSLayoutConstraint.activate([
            videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            videoLengthLabel.widthAnchor.constraint(equalToConstant: 50),
            videoLengthLabel.heightAnchor.constraint(equalToConstant: 24)
            ])
        
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(videoSlider)
        NSLayoutConstraint.activate([
            videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor, constant: 0),
            videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            videoSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor, constant: 0),
            videoSlider.heightAnchor .constraint(equalToConstant: 30)
            ])
        
        
        backgroundColor = .black
    }
    
    var player: AVPlayer?
    
    // set AVPlayer
    fileprivate func setupPlayerView() {
        let urlString = "https://firebasestorage.googleapis.com/v0/b/videofortest-ba0fb.appspot.com/o/Coastline%20-%203581.mp4?alt=media&token=6dbab536-2bb4-4130-842d-06cab014b8a5"
        
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            
            // добавим как слой на вью
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            
            // чтобы знать когда видео готово к проигрыванию
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            // track player progress
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { [weak self] progressTime in
                
                let seconds = CMTimeGetSeconds(progressTime)
                let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
                let minitsString = String(format: "%02d", Int(seconds) / 60)
                
                self?.currentTimeLabel.text = "\(minitsString):\(secondsString)"
                
                // lets move the slider thumb
                if let duration = self?.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    
                    self?.videoSlider.value = Float(seconds / durationSeconds)
                }
                
            })
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        // this is when the player is ready and rendering frames
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            
            // чтобы activityIndicatorView сразу исчез
            controlsContainerView.backgroundColor = .clear
            
            pausePlayButton.isHidden = false
            isPlaying = true
            
            // выведем длину видео
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                
                // сделаем 2-х значные секунды и минуты
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                let secondsText = String(format: "%02d", Int(seconds) % 60)
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }
    
    fileprivate func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear .cgColor, UIColor.black .cgColor]
        gradientLayer.locations = [0.7, 1.2]
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLauncher: NSObject {
    
    func showVideoPlayer() {
        if let keyWindow = UIApplication.shared.keyWindow {
            
            // основное вью
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            
            // маленький фрэйм в углу
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            // 16 x 9 is aspect ratio for all HD videos
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            // равзвернем на весь экран
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                view.frame = keyWindow.frame
                
            }, completion: { (completedAnimation) in
                
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
}












