//
//  AudioPlayer.swift
//  SoundWave
//
//  Created by Kerem Ersu on 9.06.2023.
//

import AVFoundation

final class AudioPlayer {
    
    var player: AVPlayer?
    
    func playAudio(from url: URL) {
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }
    
    func pauseAudio() {
        player?.pause()
        player = nil
    }
}
