//
//  DetailPresenter.swift
//  SoundWave
//
//  Created by Kerem Ersu on 8.06.2023.
//

import UIKit

protocol DetailPresenterProtocol {
    func viewDidLoad()
    func addToFavorite(track: Track)
    func removeFromFavorite(id: Int)
    func isFavorite(id: Int)
}

extension DetailPresenter {
    fileprivate enum Constants {
        static let pageTitle: String = "Detail"
    }
}

final class DetailPresenter {
    
    unowned var view: DetailViewControllerProtocol!
    let interactor: DetailInteractor!
    let router: DetailRouterProtocol!
    
    init(
        view: DetailViewControllerProtocol,
        interactor: DetailInteractor,
        router: DetailRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    
    func addToFavorite(track: Track) {
        interactor.addToFavorites(track: track)
    }
    
    func removeFromFavorite(id: Int) {
        interactor.removeFromFavorites(id: id)
    }
    
    func isFavorite(id: Int) {
        let isFav = interactor.isFavorite(id: id)
        view.checkFavoriteStatus(isFav)
    }
    
    func viewDidLoad() {
    

    }
}
