//
//  NetworkManager.swift
//  
//
//  Created by Kerem Ersu on 7.06.2023.
//

import Alamofire
import Foundation

public final class NetworkManager {
    public static let shared = NetworkManager()
    
    public func request<T: Decodable>(type: T.Type, url: String, method: HTTPMethod, completion: @escaping((Result<T, NetworkError>)->())) {
        AF.request(url, method: method).responseData { response in
            switch response.result {
            case .success(let data):
                self.handleResponse(data: data) { response in
                    completion(response)
                }
            case.failure(_):
                completion(.failure(.requestFailed))
            }
        }
    }
    
    fileprivate func handleResponse<T: Decodable>(data: Data, completion: @escaping((Result<T, NetworkError>)->())) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(.jsonDecodedError))
        }
    }
}
