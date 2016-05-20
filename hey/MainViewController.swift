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
    
    let heyPlayer = HeyPlayer()
    @IBOutlet weak var heyButton: UIButton!
    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.playerItemEndReached), name: AVPlayerItemDidPlayToEndTimeNotification, object: self.heyPlayer.player.currentItem)
    }
    
    
    @IBAction func heyButtonTapped(sender: AnyObject) {
        guard let player = heyPlayer.player else {
            return
        }
        if heyPlayer.playing() {
            player.pause()
        } else {
            player.play()
        }
    }
    
    func playerItemEndReached(notificaiton: NSNotification) {
        guard let player = heyPlayer.player else {
            return
        }
        player.seekToTime(kCMTimeZero)
        player.play()
    }
    
}