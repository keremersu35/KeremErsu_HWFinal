//
//  TrackCellPresenter.swift
//  SoundWave
//
//  Created by Kerem Ersu on 15.06.2023.
//

import UIKit

protocol TrackCellPresenterProtocol: AnyObject {
    func setup()
}

final class TrackCellPresenter {
    
    weak var view: TrackCellProtocol?
    private let track: TrackCellModel
    
    init(
        view: TrackCellProtocol?,
        track: TrackCellModel
    ){
        self.view = view
        self.track = track
    }
}

extension TrackCellPresenter: TrackCellPresenterProtocol {
   
    func setup() {
        
        ImageDownloader.shared.image(
            track: Track(
                kind: "",
                trackID: 0,
                artistName: track.artistName,
                collectionName: "",
                trackName: track.trackName,
                previewURL: track.previewUrl,
                artworkUrl100: track.imageUrl
            ))
        { [weak self] data, error in
            
            guard let self else { return }
            
            if let data {
                guard let img = UIImage(data: data) else { return }
                self.view?.setImage(img)
            }
        }
        view?.setTrackName(track.trackName)
        view?.setArtistName(track.artistName)
    }
}
