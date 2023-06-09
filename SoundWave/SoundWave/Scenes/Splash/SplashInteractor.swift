//
//  SplashInteractor.swift
//  SoundWave
//
//  Created by Kerem Ersu on 8.06.2023.
//

import Foundation

protocol SplashInteractorProtocol {
    func checkInternetConnection()
}

protocol SplashInteractorOutputProtocol {
    func internetConnection(status: Bool)
}

final class SplashInteractor {
    var output: SplashInteractorOutputProtocol?
}

extension SplashInteractor: SplashInteractorProtocol {
    
    func checkInternetConnection() {
        let internetStatus = SoundWaveManager.shared.isConnectedToInternet()
        self.output?.internetConnection(status: internetStatus)
    }
}
