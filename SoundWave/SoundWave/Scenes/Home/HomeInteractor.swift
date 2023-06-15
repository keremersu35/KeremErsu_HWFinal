//
//  HomeInteractor.swift
//  SoundWave
//
//  Created by Kerem Ersu on 7.06.2023.
//

import Foundation
import Network

typealias TracksSourcesResult = Result<Tracks, NetworkError>

protocol HomeInteractorProtocol: AnyObject {
    func fetchTracks(query: String)
    func getAllFavorites() -> [Favorite]
}

protocol HomeInteractorOutputProtocol {
    func fetchTracksOutput(_ result: Result<Tracks, NetworkError>)
}

fileprivate var trackService: SoundWaveManagerProtocol = SoundWaveManager()

final class HomeInteractor {
    var output: HomeInteractorOutputProtocol?
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func getAllFavorites() -> [Favorite] {
        CoreDataManager().getAllFavorites()
    }
    
    func fetchTracks(query: String) {
        trackService.getTracks(query: query.replacingOccurrences(of: " ", with: "+")) { [weak self] response, error in
            guard let self else { return }
            if let error = error {
                let result: TracksSourcesResult = .failure(error)
                self.output?.fetchTracksOutput(result)
            } else if let response = response {
                let result: TracksSourcesResult = .success(response)
                self.output?.fetchTracksOutput(result)
            }
        }
    }
}
