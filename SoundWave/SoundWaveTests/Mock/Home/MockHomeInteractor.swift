//
//  MockHomeInteractor.swift
//  SoundWaveTests
//
//  Created by Kerem Ersu on 16.06.2023.
//

import Foundation
@testable import SoundWave

final class MockHomeInteractor: HomeInteractorProtocol {
    
    var isInvokedFetchTracks = false
    var inkovedFetchTracksCount = 0
    
    func fetchTracks(query: String) {
        isInvokedFetchTracks = true
        inkovedFetchTracksCount += 1
    }
}
