//
//  PresenterRouter.swift
//  SoundWave
//
//  Created by Kerem Ersu on 15.06.2023.
//

import Foundation

protocol FavoritesRouterProtocol {
    func navigate(_ route: FavoritesRoutes)
}

enum FavoritesRoutes {
    case detail(source: Track?)
}

final class FavoritesRouter {
    
    weak var viewController: FavoritesViewController?
    
    static func createModule() -> FavoritesViewController {
        let view = FavoritesViewController()
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter()
        let presenter = FavoritesPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        router.viewController = view
        return view
    }
}

extension FavoritesRouter: FavoritesRouterProtocol {
    
    func navigate(_ route: FavoritesRoutes) {
        switch route {
        case .detail(let source):
            
            let detailVC = DetailRouter.createModule()
            detailVC.source = source
            viewController?.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

