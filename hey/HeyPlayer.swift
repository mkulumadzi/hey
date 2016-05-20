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
    
    var audioPlayer:AudioPlayer!
    
    init() {
        do {
            try self.audioPlayer = AudioPlayer(fileName: "heyLoop.mp3")
            self.audioPlayer.numberOfLoops = -1
        } catch {
            print(error)
        }
        
    }
    
}