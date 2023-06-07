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
    func getTracks() -> [Track]
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
        
    }
    
    func numberOfItems() -> Int {
        10
    }
    
    func getTracks() -> [Track] {
        tracks
    }
    
    func didSelectRowAt(index: Int) {
        
    }
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func fetchTracksOutput(_ result: Result<Tracks, NetworkError>) {
        
        view.hideLoadingView()
        switch result {
        case .success(let response):
            self.news = response.results!
            view.reloadData()
        case .failure(let error):
            view.showError(error.localizedDescription)
        }
    }
}
