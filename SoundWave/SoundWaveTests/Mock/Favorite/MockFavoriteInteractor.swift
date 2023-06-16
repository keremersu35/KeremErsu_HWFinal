//
//  MockFavoriteInteractor.swift
//  SoundWaveTests
//
//  Created by Kerem Ersu on 16.06.2023.
//

import Foundation
import CoreData
@testable import SoundWave
import XCTest

final class MockFavoriteInteractor: FavoritesInteractorProtocol {
    
    var isInvokedGetAllFavorites = false
    var inkovedGetAllFavoritesCount = 0
    
    func getAllFavorites() -> [Favorite]? {
        isInvokedGetAllFavorites = true
        inkovedGetAllFavoritesCount += 1
        return []
    }
    
    var isInvokedRemoveFromFavorites = false
    var inkovedRemoveFromFavoritesCount = 0
    var invokedRemoveFromFavoritesParameters: (id: Int, Void)?
    
    func removeFromFavorites(id: Int) {
        isInvokedRemoveFromFavorites = true
        inkovedRemoveFromFavoritesCount += 1
        invokedRemoveFromFavoritesParameters = (id, ())
    }
}

