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
import NTPKit

private let beatLength = 0.625

protocol HeyPlayerDelegate {
    func playerPlayed()
    func playerStopped()
}

class HeyPlayer {
    
    var audioPlayer:AudioPlayer!
    var clockOffset:Double!
    var delegate:HeyPlayerDelegate!
    let server = NTPServer.defaultServer()
    
    var playerOffset:Double {
        get {
            let interval = NSDate().timeIntervalSince1970 + clockOffset
            let offset = beatLength - ( interval % beatLength )
            return offset
        }
    }
    
    init() {
        do {
            try self.audioPlayer = AudioPlayer(fileName: "heyLoop.mp3")
            self.audioPlayer.numberOfLoops = -1
            self.synchronizeClocks()
        } catch {
            print(error)
        }
    }
    
    // MARK: Timing functions
    
    private func synchronizeClocks() {
        if let date = try? server.date() {
            // Get the network time using NTP and calculate the offset (in seconds) from that time and the system clock)
            let networkInterval = date.timeIntervalSince1970
            let clockInterval = NSDate().timeIntervalSince1970
            clockOffset = networkInterval - clockInterval
        } else {
            clockOffset = 0
        }
    }
    
    
    // MARK: User actions
    
    func toggle() {
        if audioPlayer.playing {
            stopPlaying()
        } else {
            startPlaying()
        }
    }
    
    // MARK: Private
    
    private func stopPlaying() {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        delegate.playerStopped()
    }
    
    private func startPlaying() {
        let _ = NSTimer.scheduledTimerWithTimeInterval(playerOffset, target: self, selector: #selector(self.playAfterDelay), userInfo: nil, repeats: false)
    }
    
    @objc func playAfterDelay() {
        audioPlayer.play()
        delegate.playerPlayed()
    }
    
}