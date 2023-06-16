//
//  AudioPlayer.swift
//  SoundWave
//
//  Created by Kerem Ersu on 9.06.2023.
//

import AVFoundation

final class AudioPlayer {
    
    var player: AVPlayer?
    private var playerItem: AVPlayerItem?
    
    func playAudio(from url: URL) {
        let playerItem = AVPlayerItem(url: url)
        self.playerItem = playerItem
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            self.player = AVPlayer(playerItem: playerItem)
            self.player?.play()
        }
    }
    
    func pauseAudio() {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            self.player?.pause()
            self.player = nil
            self.playerItem = nil
        }
    }
    
    func resumeAudio() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.player?.play()
        }
    }
}
