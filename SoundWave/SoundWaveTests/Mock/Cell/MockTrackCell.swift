//
//  MockTrackCell.swift
//  SoundWaveTests
//
//  Created by Kerem Ersu on 16.06.2023.
//

import UIKit
@testable import SoundWave

final class MockTrackCell: TrackCellProtocol {
    
    var isInvokedSetButtonImageAsPlay = false
    var invokedSetButtonImageAsPlayCount = 0
    
    func setButtonImageAsPlay() {
        isInvokedSetButtonImageAsPlay = true
        invokedSetButtonImageAsPlayCount += 1
    }
    
    var isInvokedCheckIsPlaying = false
    var invokedCheckIsPlayingCount = 0
    
    func checkIsPlaying() -> Bool {
        isInvokedCheckIsPlaying = true
        invokedCheckIsPlayingCount += 1
        return isInvokedCheckIsPlaying
    }
    
    var isInvokedSetIsPlayingAsFalse = false
    var invokedSetIsPlayingAsFalseCount = 0
    
    func setIsPlayingAsFalse() {
        isInvokedSetIsPlayingAsFalse = true
        invokedSetIsPlayingAsFalseCount += 1
    }
    
    var isInvokedSetTrackNameLabel = false
    var invokedSetTrackNameLabelCount = 0
    var invokedSetTrackNameLabelParameters: (text: String, Void)?
    
    func setTrackName(_ name: String) {
        isInvokedSetTrackNameLabel = true
        invokedSetTrackNameLabelCount += 1
        invokedSetTrackNameLabelParameters = (name, ())
    }
    
    var isInvokedSetArtistNameLabel = false
    var invokedSetArtistNameLabelCount = 0
    var invokedSetArtistNameLabelParameters: (text: String, Void)?
    
    func setArtistName(_ name: String) {
        isInvokedSetArtistNameLabel = true
        invokedSetArtistNameLabelCount += 1
        invokedSetArtistNameLabelParameters = (name, ())
    }
    
    var isInvokedSetTrackImageView = false
    var invokedNewsTrackViewCount = 0
    var invokedSetTrackImageViewParameters: (image: UIImage, Void)?
    
    func setImage(_ image: UIImage) {
        isInvokedSetTrackImageView = true
        invokedNewsTrackViewCount += 1
        invokedSetTrackImageViewParameters = (image, ())
    }
}
