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

class MainViewController: UIViewController {
    
    var heyPlayer:HeyPlayer!
    @IBOutlet weak var heyButton: UIButton!
    @IBOutlet weak var tintedView: UIView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tintedView.alpha = 0.0
        heyButton.hidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        heyPlayer = HeyPlayer()
        heyButton.hidden = false
    }
    
    
    @IBAction func heyButtonTapped(sender: AnyObject) {
        guard let player = heyPlayer.audioPlayer else {
            return
        }
        if player.playing {
            player.stop()
            stopPulse()
        } else {
            player.play()
            pulse()
        }
    }
    
    func pulse() {
        weak var weakSelf = self
        UIView.animateWithDuration(0.3125, delay: 0.0, options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat], animations: {
           weakSelf?.tintedView.alpha = 0.2
        }, completion: nil)
        
        UIView.animateWithDuration(2.5, delay: 0.0, options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat], animations: {
            weakSelf?.view.backgroundColor = UIColor.heyBlue()
            }, completion: nil)
        
    }
    
    func stopPulse() {
        tintedView.layer.removeAllAnimations()
    }
    
}