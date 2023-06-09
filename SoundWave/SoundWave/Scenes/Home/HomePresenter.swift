//
//  HomePresenter.swift
//  SoundWave
//
//  Created by Kerem Ersu on 7.06.2023.
//

import Foundation
import Network

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfItems() -> Int
    func getTrack(_ index: Int) -> Track?
    func didSelectRowAt(index: Int)
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
    
    func viewDidLoad() {
        view.setupTableView()
        view.setTitle("SoundWave")
        fetchTracks()
    }
    
    func numberOfItems() -> Int {
        tracks.count
    }
    
    func getTrack(_ index: Int) -> Track? {
        tracks[index]
    }
    
    func didSelectRowAt(index: Int) {
        guard let source = getTrack(index) else { return }
        router.navigate(.detail(source: source))
    }
    
    private func fetchTracks() {
        view.showLoadingView()
        interactor.fetchTracks(query: "tarkan")
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func fetchTracksOutput(_ result: Result<Tracks, NetworkError>) {
        
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
