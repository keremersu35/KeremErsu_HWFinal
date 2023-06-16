//
//  MockDetailInteractor.swift
//  SoundWaveTests
//
//  Created by Kerem Ersu on 16.06.2023.
//

import Foundation
@testable import SoundWave

final class MockDetailInteractor: DetailInteractorProtocol {
    
    var isInvokedAddToFavorites = false
    var inkovedAddToFavoritesCount = 0
    var invokedAddToFavoritesParameters: (track: Track, Void)?
    
    func addToFavorites(track: Track) {
        isInvokedAddToFavorites = true
        inkovedAddToFavoritesCount += 1
        invokedAddToFavoritesParameters = (track, ())
    }
    
    var isInvokedRemoveFromFavorites = false
    var inkovedRemoveFromFavoritesCount = 0
    var invokedRemoveFromFavoritesParameters: (id: Int, Void)?
    
    func removeFromFavorites(id: Int) {
        isInvokedRemoveFromFavorites = true
        inkovedRemoveFromFavoritesCount += 1
        invokedRemoveFromFavoritesParameters = (id, ())
    }
    
    var isInvokedIsFavorite = false
    var inkovedIsFavoriteCount = 0
    var invokedIsFavoriteParameters: (id: Int, Void)?
    
    func isFavorite(id: Int) -> Bool {
        isInvokedIsFavorite = true
        inkovedIsFavoriteCount += 1
        invokedIsFavoriteParameters = (id, ())
        return isInvokedIsFavorite
    }
}

