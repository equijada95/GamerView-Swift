//
//  VideoPlayer.swift
//  Videojuegos
//
//  Created by MIMO on 04/05/2020.
//  Copyright © 2020 MIMO. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoPlayer
{
    
    func playVideo(urlVideo: String) -> AVPlayerViewController{
        let playerViewController = AVPlayerViewController()
        let videoURL = URL(string: urlVideo)!
        let player = AVPlayer(url: videoURL)
        playerViewController.player = player
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
        }
        catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        return playerViewController
    }
}
