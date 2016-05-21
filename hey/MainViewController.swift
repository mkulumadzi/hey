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
import NTPKit

class MainViewController: UIViewController {
    
    var heyPlayer:HeyPlayer!
    @IBOutlet weak var heyButton: UIButton!
    @IBOutlet weak var tintedView: UIView!
    
    var timer:NSTimer!
    var currentColor:UIColor!
    
    let server = NTPServer.defaultServer()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        formatView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        heyPlayer = HeyPlayer()
        heyButton.hidden = false
    }
    
    func formatView() {
        guard let font = UIFont(name: "OpenSans-Bold", size: 96.0) else {
            return
        }
        tintedView.alpha = 0.0
        heyButton.hidden = true
        
        let attributes = [NSFontAttributeName:font, NSForegroundColorAttributeName: UIColor.whiteColor(), NSStrokeColorAttributeName:UIColor.blackColor(), NSStrokeWidthAttributeName:NSNumber(float: -3.0)]
        let title = NSAttributedString(string: "HEY!", attributes: attributes)
        heyButton.setAttributedTitle(title, forState: .Normal)
    }
    
    @IBAction func heyButtonTapped(sender: AnyObject) {
        guard let player = heyPlayer.audioPlayer else {
            return
        }
        if player.playing {
            player.stop()
            player.currentTime = 0
            stopPulse()
        } else {
            if let date = try? server.date() {
                let interval = date.timeIntervalSince1970
                let offset = interval % 0.625
                print(offset)
                let _ = NSTimer.scheduledTimerWithTimeInterval(offset, target: self, selector: #selector(self.playAfterDelay), userInfo: nil, repeats: false)
            } else {
                playAfterDelay()
            }
        }
    }
    
    func playAfterDelay() {
        guard let player = heyPlayer.audioPlayer else {
            return
        }
        player.play()
        pulse()
    }
    
    func pulse() {
        
        weak var weakSelf = self
        UIView.animateWithDuration(0.3125, delay: 0.0, options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat], animations: {
           weakSelf?.tintedView.alpha = 0.25
        }, completion: nil)
        
        currentColor = UIColor.heyYellow()
        timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
    }
    
    func update() {
        getNextColor()
        weak var weakSelf = self
        UIView.animateWithDuration(2.5, animations: {
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
        timer.invalidate()
        tintedView.layer.removeAllAnimations()
        tintedView.alpha = 0.0
        
        currentColor = UIColor.heyYellow()
        weak var weakSelf = self
        UIView.animateWithDuration(1.25, animations: {
            weakSelf?.view.backgroundColor = weakSelf?.currentColor
        })
        
    }
    
}