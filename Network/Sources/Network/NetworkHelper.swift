//
//  File.swift
//  
//
//  Created by Kerem Ersu on 7.06.2023.
//

import Foundation

public enum ErrorTypes: String, Error {
    case invalidData = "Invalid data"
    case invalidUrl = "invalid url"
    case generalError = "An error happened"
}

public final class NetworkHelper {
    public static let shared = NetworkHelper()
    
    private var baseURL = "https://itunes.apple.com/search?"
    
    public func requestUrl(_ url: String) -> String {
        baseURL + url
    }
}
