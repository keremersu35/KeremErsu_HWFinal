//
//  SoundWaveNetworkManager.swift
//  SoundWave
//
//  Created by Kerem Ersu on 7.06.2023.
//

import Foundation
import Network

protocol SoundWaveManagerProtocol: AnyObject {
    func getTracks(query: String, complete: @escaping((Tracks?, NetworkError?)->()))
}

final class SoundWaveManager: SoundWaveManagerProtocol {
    public static let shared = SoundWaveManager()
    
    func getTracks(query: String, complete: @escaping((Tracks?, NetworkError?)->())) {
        NetworkManager.shared.request(type: Tracks.self, url: NetworkHelper.shared.requestUrl(query.lowercased().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!), method: .get)
        { response in
            switch response {
            case .success(let data):
                complete(data, nil)
            case.failure(let error):
                print(error)
                complete(nil, error)
            }
        }
    }
}

extension SoundWaveManager {
    
    func isConnectedToInternet() -> Bool {
        return Reachability.isConnectedToNetwork()
    }
}
