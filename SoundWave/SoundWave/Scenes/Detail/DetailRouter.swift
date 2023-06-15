//
//  DetailRouter.swift
//  SoundWave
//
//  Created by Kerem Ersu on 8.06.2023.
//

import Foundation
import SafariServices

protocol DetailRouterProtocol {
    func navigate(_ route: DetailRoutes)
}

enum DetailRoutes {
    case openURL(url: URL)
}

final class DetailRouter {
    
    weak var viewController: DetailViewController?
    
    static func createModule() -> DetailViewController {
        let view = DetailViewController()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        let presenter = DetailPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        router.viewController = view
        return view
    }
}

extension DetailRouter: DetailRouterProtocol {
    
    func navigate(_ route: DetailRoutes) {
        
        switch route {
        case .openURL(let url):
            let urlForNews = SFSafariViewController(url: url)
            viewController?.present(urlForNews, animated: true)
        }
    }
}
