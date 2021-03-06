//
//  MainViewController.swift
//  hey
//
//  Created by Evan Waters on 5/20/16.
//  Copyright © 2016 Evan Waters. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class MainViewController: UIViewController, HeyPlayerDelegate {
    
    var heyPlayer:HeyPlayer!
    @IBOutlet weak var heyButton: UIButton!
    @IBOutlet weak var heyLabel: UILabel!
    @IBOutlet weak var tintedView: UIView!
    @IBOutlet weak var patternImage: UIImageView!
    
    let patternImages = ["vector-tile", "honeycomb", "circles.png", "winter_pattern.png"]
    var patternImageIndex = 0
    
    var colorTimer:Timer!
    var imageTimer:Timer!
    var currentColor:UIColor!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        formatView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        heyPlayer = HeyPlayer()
        heyPlayer.delegate = self
        heyButton.isHidden = false
    }
    
    func formatView() {
        guard let font = UIFont(name: "OpenSans-Bold", size: 96.0) else {
            return
        }
        tintedView.alpha = 0.0
        heyButton.isHidden = true
        patternImage.alpha = 0.0
        
        let attributes = [NSFontAttributeName:font, NSForegroundColorAttributeName: UIColor.white, NSStrokeColorAttributeName:UIColor.black, NSStrokeWidthAttributeName:NSNumber(value: -3.0 as Float)]
        let title = NSAttributedString(string: "HEY!", attributes: attributes)
        heyLabel.attributedText = title
        
        setPatternImage()
    }
    
    // MARK: User actions
    
    @IBAction func heyButtonTapped(_ sender: AnyObject) {
        guard let player = heyPlayer else {
            return
        }
        player.toggle()
    }
    
    // MARK: Delegate functions
    
    func playerStopped() {
        stopPulse()
    }
    
    func playerPlayed() {
        pulse()
    }
    
    // MARK: View animations

    func pulse() {
        weak var weakSelf = self
        UIView.animate(withDuration: 0.3125, delay: 0.0, options: [UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.repeat], animations: {
            weakSelf?.tintedView.alpha = 0.25
            weakSelf?.heyLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: nil)
        
        currentColor = UIColor.heyYellow()
        colorTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
        fadeVectorImageInOut()
        
    }
    
    func fadeVectorImageInOut() {
        weak var weakSelf = self
        UIView.animate(withDuration: 2.5, delay: 0.0, options: [UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.repeat], animations: {
            weakSelf?.patternImage.alpha = 0.2
            }, completion: nil)
        imageTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.setPatternImage), userInfo: nil, repeats: true)
    }
    
    func setPatternImage() {
        let imageName = patternImages[patternImageIndex]
        if let image = UIImage(named: imageName) {
            patternImage.image = image
        }
        
        if patternImageIndex < patternImages.count - 1 {
            patternImageIndex += 1
        } else {
            patternImageIndex = 0
        }
    }
    
    func update() {
        getNextColor()
        weak var weakSelf = self
        UIView.animate(withDuration: 2.5, animations: {
            weakSelf?.view.backgroundColor = weakSelf?.currentColor
        })
    }

    func getNextColor() {
        if currentColor == UIColor.heyYellow() {
            currentColor = UIColor.heyGreen()
        } else if currentColor == UIColor.heyGreen() {
            currentColor = UIColor.heyBlue()
        } else if currentColor == UIColor.heyBlue() {
            currentColor = UIColor.heyPurple()
        } else if currentColor == UIColor.heyPurple() {
            currentColor = UIColor.heyRed()
        } else if currentColor == UIColor.heyRed() {
            currentColor = UIColor.heyOrange()
        } else {
            currentColor = UIColor.heyYellow()
        }
    }
    
    func stopPulse() {
        colorTimer.invalidate()
        imageTimer.invalidate()
        tintedView.layer.removeAllAnimations()
        tintedView.alpha = 0.0
        patternImage.layer.removeAllAnimations()
        patternImage.alpha = 0.0
        heyLabel.layer.removeAllAnimations()
        heyLabel.transform = CGAffineTransform.identity
        currentColor = UIColor.heyYellow()
        weak var weakSelf = self
        UIView.animate(withDuration: 1.25, animations: {
            weakSelf?.view.backgroundColor = weakSelf?.currentColor
        })
        
    }
    
}
