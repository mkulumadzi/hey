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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
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
        } else {
            player.play()
        }
    }
    
}