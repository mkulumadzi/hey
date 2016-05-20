//
//  HeyPlayer.swift
//  hey
//
//  Created by Evan Waters on 5/20/16.
//  Copyright © 2016 Evan Waters. All rights reserved.
//

import Foundation
import AVFoundation
import AudioPlayer

private let audioFile = "heyLoop"

class HeyPlayer {
    
    
    var player:AVPlayer!
    var audioPlayer:AudioPlayer!
    
    init() {
        if let path = NSBundle.mainBundle().pathForResource(audioFile, ofType: "aiff") {
            let url = NSURL(fileURLWithPath: path)
            self.player = AVPlayer(URL: url)
        }
        do {
            try self.audioPlayer = AudioPlayer(fileName: "heyLoop.aiff")
            self.audioPlayer.numberOfLoops = -1
        } catch {
            print(error)
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