//
//  File.swift
//  
//
//  Created by Kerem Ersu on 7.06.2023.
//

import Foundation
import Extensions

public enum NetworkError: Error {
    case invalidRequest
    case requestFailed
    case jsonDecodedError
    case customError(Error)

    var localizedDescription: String {
        switch self {
        case .invalidRequest:
            return "Invalid Request"
        case .requestFailed:
            return "Request Failed"
        case .jsonDecodedError:
            return "JSON Decoded Error"
        case .customError(let error):
            return error.localizedDescription
        }
    }
}

public final class NetworkHelper {
    public static let shared = NetworkHelper()
    
    private var baseURL = "https://itunes.apple.com/search?country=TR&media=all&entity=song&attribute=mixTerm&term="
    
    public func requestUrl(_ url: String) -> String {
        return baseURL + url
    }
}
