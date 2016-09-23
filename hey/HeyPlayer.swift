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
//import NTPKit

private let beatLength = 0.625

protocol HeyPlayerDelegate {
    func playerPlayed()
    func playerStopped()
}

class HeyPlayer {
    
    var audioPlayer:AudioPlayer!
    var clockOffset:Double!
    var delegate:HeyPlayerDelegate!
    //let server = NTPServer.default()
    
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
    
    fileprivate func synchronizeClocks() {
        //if let date = try? server.date() {
            // Get the network time using NTP and calculate the offset (in seconds) from that time and the system clock)
            //let networkInterval = date.timeIntervalSince1970
            //let clockInterval = Date().timeIntervalSince1970
            //clockOffset = networkInterval - clockInterval
        //} else {
            clockOffset = 0
        //}
    }
    
    var playerOffset:Double {
        // This value is used to calculate the amount of time (in fractions of a second) that the player should wait before beginning to play the track.
        get {
            let interval = Date().timeIntervalSince1970 + clockOffset
            let offset = beatLength - ( interval.truncatingRemainder(dividingBy: beatLength) )
            return offset
        }
    }
    
    
    // MARK: User actions
    
    func toggle() {
        if audioPlayer.isPlaying {
            stopPlaying()
        } else {
            startPlaying()
        }
    }
    
    // MARK: Private
    
    fileprivate func stopPlaying() {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        delegate.playerStopped()
    }
    
    fileprivate func startPlaying() {
        let _ = Timer.scheduledTimer(timeInterval: playerOffset, target: self, selector: #selector(self.playAfterDelay), userInfo: nil, repeats: false)
    }
    
    @objc func playAfterDelay() {
        audioPlayer.play()
        delegate.playerPlayed()
    }
    
}
