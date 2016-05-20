//
//  HeyPlayer.swift
//  hey
//
//  Created by Evan Waters on 5/20/16.
//  Copyright © 2016 Evan Waters. All rights reserved.
//

import Foundation
import AVFoundation

private let audioFile = "Chant_beat_5s-1"

class HeyPlayer {
    
    
    var player:AVPlayer!
    
    init() {
        if let path = NSBundle.mainBundle().pathForResource(audioFile, ofType: "mp3") {
            let url = NSURL(fileURLWithPath: path)
            self.player = AVPlayer(URL: url)
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