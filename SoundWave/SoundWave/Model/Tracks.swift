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
    let artistID: Int?
    let collectionID: Int?
    let trackID: Int?
    let artistName, collectionName: String?
    let trackName: String?
    let trackViewURL: String?
    let previewURL: String?
    let artworkUrl30: String?
    let artworkUrl60, artworkUrl100: String?
    let releaseDate: String?
    let discCount, discNumber: Int?
    let trackCount: Int?
    let primaryGenreName: String?
    let contentAdvisoryRating: String?
    let genres: [String]?
    let description, collectionArtistName: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, releaseDate, discCount, discNumber, trackCount, primaryGenreName, contentAdvisoryRating
        case genres, description, collectionArtistName
    }
}
