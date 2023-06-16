//
//  Tracks.swift
//  SoundWave
//
//  Created by Kerem Ersu on 7.06.2023.
//

import Foundation

struct Tracks: Decodable {
    let resultCount: Int?
    let results: [Track]?
}

struct Track: Decodable {
    let kind: String?
    let trackID: Int?
    let artistName, collectionName: String?
    let trackName: String?
    let previewURL: String?
    let artworkUrl100: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case trackID = "trackId"
        case artistName, collectionName, trackName
        case previewURL = "previewUrl"
        case artworkUrl100
    }
}
