//
//  MockDetailViewController.swift
//  SoundWaveTests
//
//  Created by Kerem Ersu on 16.06.2023.
//

import UIKit
@testable import SoundWave

final class MockDetailViewController: DetailViewControllerProtocol {
    
    var isInvokedSetTitle = false
    var invokedSetTitleCount = 0
    var invokedSetTitleParameters: (title:String, Void)?
    
    func setTitle(_ title: String) {
        isInvokedSetTitle = true
        invokedSetTitleCount += 1
        invokedSetTitleParameters = (title, ())
    }
    
    var isInvokedGetSource = false
    var invokedGetSourceCount = 0
    
    func getSource() -> Track? {
        isInvokedGetSource = true
        invokedGetSourceCount += 1
        return Track(
            kind: "Simge",
            trackID: 0,
            artistName: "Simge",
            collectionName: "Ben Bazen",
            trackName: "Aşkın Olayım",
            previewURL: "",
            artworkUrl100: ""
        )
    }
    
    var isInvokedSetImage = false
    var invokedSetImage = 0
    var invokedSetImageParameters: (image: UIImage, Void)?
    
    func setImage(_ image: UIImage) {
        isInvokedSetImage = true
        invokedSetImage += 1
        invokedSetImageParameters = (image, ())
    }
    
    var isInvokedSetTrackName = false
    var invokedSetTrackNameCount = 0
    var invokedSetTrackNameParameters: (name: String, Void)?
    
    func setTrackName(_ name: String) {
        isInvokedSetTrackName = true
        invokedSetTrackNameCount += 1
        invokedSetTrackNameParameters = (name, ())
    }
    
    var isInvokedSetAlbumName = false
    var invokedSetAlbumNameCount = 0
    var invokedSetAlbumNameParameters: (name: String, Void)?
    
    func setAlbumName(_ name: String) {
        isInvokedSetAlbumName = true
        invokedSetAlbumNameCount += 1
        invokedSetAlbumNameParameters = (name, ())
    }
    
    var isInvokedSetArtistName = false
    var invokedSetArtistNameCount = 0
    var invokedSetArtistNameParameters: (name: String, Void)?
    
    func setArtistName(_ name: String) {
        isInvokedSetArtistName = true
        invokedSetArtistNameCount += 1
        invokedSetArtistNameParameters = (name, ())
    }
    
    var isInvokedFavoriteButtonTapped = false
    var invokedFavoriteButtonTappedCount = 0
    var invokedFavoriteButtonTappedParameters: (isFavorite: Bool, Void)?
    
    func favoriteButtonTapped(_ isFavorite: Bool) {
        isInvokedFavoriteButtonTapped = true
        invokedFavoriteButtonTappedCount += 1
        invokedFavoriteButtonTappedParameters = (isFavorite, ())
    }
    
    var isInvokedCheckFavorite = false
    var invokedCheckFavoriteCount = 0
    var invokedCheckFavoriteParameters: (isFavorite: Bool, Void)?
    
    func checkFavorite(_ isFavorite: Bool) {
        isInvokedCheckFavorite = true
        invokedCheckFavoriteCount += 1
        invokedCheckFavoriteParameters = (isFavorite, ())
    }
    
    var isInvokedPlayButtonTapped = false
    var invokedPlayButtonTappedCount = 0
    var invokedPlayButtonTappedParameters: (isPlaying: Bool, Void)?
    
    func playButtonTapped(_ isPlaying: Bool) {
        isInvokedPlayButtonTapped = true
        invokedPlayButtonTappedCount += 1
        invokedPlayButtonTappedParameters = (isPlaying, ())
    }
}
