//
//  MockDetailRouter.swift
//  SoundWaveTests
//
//  Created by Kerem Ersu on 16.06.2023.
//

import Foundation
@testable import SoundWave

final class MockDetailRouter: DetailRouterProtocol {
    
    var isInvokedNavigate = false
    var invokedNavigateCount = 0
    var invokedNavigateParameters: (route: DetailRoutes, Void)?
    
    func navigate(_ route: DetailRoutes) {
        isInvokedNavigate = true
        invokedNavigateCount += 1
        invokedNavigateParameters = (route, ())
    }
}
