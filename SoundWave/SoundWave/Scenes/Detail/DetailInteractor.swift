//
//  DetailInteractor.swift
//  SoundWave
//
//  Created by Kerem Ersu on 8.06.2023.
//


import Foundation

protocol DetailInteractorProtocol {
    func addToFavorites(track: Track)
    func removeFromFavorites(id: Int)
    func isFavorite(id: Int) -> Bool
}

protocol DetailInteractorOutputProtocol {
    func saveToFavoritesOutput()
}

final class DetailInteractor {
    var output: HomeInteractorOutputProtocol?
}

extension DetailInteractor: DetailInteractorProtocol {
    
    func isFavorite(id: Int) -> Bool {
        CoreDataManager().isFavorite(trackID: id)
    }
    
    func removeFromFavorites(id: Int) {
        CoreDataManager().removeTrackFromFavorites(trackID: id)
    }
    
    func addToFavorites(track: Track) {
        CoreDataManager().addTrackToFavorites(track: track)
    }
}
