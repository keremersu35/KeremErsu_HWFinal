//
//  HomePresenter.swift
//  SoundWave
//
//  Created by Kerem Ersu on 7.06.2023.
//

import Foundation
import Network
import Extensions

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func getTrackCellModel(_ index: Int) -> TrackCellModel?
    func getTrack(_ index: Int) -> Track?
    func didSelectRowAt(index: Int)
    func fetchData(query: String)
    func navigateToFavorites()
}

final class HomePresenter {
   
    unowned var view: HomeViewControllerProtocol
    let router: HomeRouterProtocol!
    let interactor: HomeInteractorProtocol!
    
    var tracks: [Track] = []
    
    init(
         view: HomeViewControllerProtocol,
         router: HomeRouterProtocol,
         interactor: HomeInteractorProtocol)
    {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

extension HomePresenter: HomePresenterProtocol {
    
    func navigateToFavorites() {
        router.navigate(.favorites)
    }
    
    func fetchData(query: String) {
        fetchTracks(query: query)
    }
    
    func viewDidLoad() {
        view.setupTableView()
        view.setTitle("SoundWave")
    }
    
    func numberOfItems() -> Int {
        tracks.count
    }
    
    func getTrack(_ index: Int) -> Track? {
        tracks[index]
    }
    
    func getTrackCellModel(_ index: Int) -> TrackCellModel? {
        var trackCellModel: TrackCellModel? = nil
        if let model = getTrack(index) {
            trackCellModel = TrackCellModel(
                trackName: model.trackName ?? "",
                artistName: model.artistName ?? "",
                imageUrl: model.artworkUrl100 ?? "",
                previewUrl: model.previewURL ?? "")
        }
        return trackCellModel ?? nil
    }
    
    func didSelectRowAt(index: Int) {
        guard let source = getTrack(index) else { return }
        router.navigate(.detail(source: source))
    }
    
    func fetchTracks(query: String) {
        view.showLoadingView()
        interactor.fetchTracks(query: query.convertingTurkishCharactersToEnglish())
        view.reloadData()
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func fetchTracksOutput(_ result: TracksSourcesResult) {
        
        view.hideLoadingView()
        switch result {
        case .success(let response):
            self.tracks = response.results!
            view.reloadData()
        case .failure(let error):
            view.showError(error.localizedDescription)
        }
    }
}
