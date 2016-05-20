//
//  HeyPlayer.swift
//  hey
//
//  Created by Evan Waters on 5/20/16.
//  Copyright © 2016 Evan Waters. All rights reserved.
//

import Foundation
import AVFoundation

private let audioFile = "heyLoop"

class HeyPlayer {
    
    
    var player:AVPlayer!
    
    init() {
        if let path = NSBundle.mainBundle().pathForResource(audioFile, ofType: "aiff") {
            let url = NSURL(fileURLWithPath: path)
            self.player = AVPlayer(URL: url)
        } else {
            
        }
    }
    
    func playing() -> Bool {
        guard let player = self.player else {
            return false
        }
        if (player.rate != 0 && player.error == nil) {
            return true
        } else {
            return false
        }
    }
    
    
    
    
}