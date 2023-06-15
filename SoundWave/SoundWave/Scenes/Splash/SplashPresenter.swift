//
//  SplashPresenter.swift
//  SoundWave
//
//  Created by Kerem Ersu on 8.06.2023.
//

import Foundation

protocol SplashPresenterProtocol {
    func viewDidAppear()
}

final class SplashPresenter {
    
    unowned var view: SplashViewControllerProtocol!
    let router: SplashRouterProtocol!
    let interactor: SplashInteractorProtocol!
    
    init(
        view: SplashViewControllerProtocol,
        router: SplashRouterProtocol,
        interactor: SplashInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
}

extension SplashPresenter: SplashPresenterProtocol {
    func viewDidAppear() {
        interactor.checkInternetConnection()
    }
}

extension SplashPresenter: SplashInteractorOutputProtocol {
    
    func internetConnectionStatus(_ status: Bool) {
        
        if status {
            DispatchQueue.main.async {
                self.router.navigate(.homeScreen)
            }
        } else {
            view.noInternetConnection()
        }
    }
}
