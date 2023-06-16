//
//  FavoritesInteractor.swift
//  SoundWave
//
//  Created by Kerem Ersu on 15.06.2023.
//

import Foundation

protocol FavoritesInteractorProtocol: AnyObject {
    func getAllFavorites() -> [Favorite]?
    func removeFromFavorites(id: Int)
}

protocol FavoritesInteractorOutputProtocol {
    func getAllFavoritesOutput()
}

final class FavoritesInteractor {
    var output: FavoritesInteractorOutputProtocol?
}

extension FavoritesInteractor: FavoritesInteractorProtocol {
    
    func removeFromFavorites(id: Int) {
        CoreDataManager().removeTrackFromFavorites(trackID: id)
    }
    
    func getAllFavorites() -> [Favorite]? {
        CoreDataManager().getAllFavorites()
    }
}
