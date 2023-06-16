//
//  FavoritesInteractor.swift
//  SoundWave
//
//  Created by Kerem Ersu on 15.06.2023.
//

import Foundation

protocol FavoritesInteractorProtocol: AnyObject {
    func getAllFavorites() -> [Favorite]?
}

protocol FavoritesInteractorOutputProtocol {
    func getAllFavoritesOutput()
}

final class FavoritesInteractor {
    var output: FavoritesInteractorOutputProtocol?
}

extension FavoritesInteractor: FavoritesInteractorProtocol {
    func getAllFavorites() -> [Favorite]? {
        CoreDataManager().getAllFavorites()
    }
}
