//
//  DetailPresenter.swift
//  SoundWave
//
//  Created by Kerem Ersu on 8.06.2023.
//

import UIKit

protocol DetailPresenterProtocol {
    func viewDidLoad()
    func viewWillAppear()
    func addToFavorite()
    func removeFromFavorite()
    func isFavorite(id: Int)
    func playButtonTapped()
    func favoriteButtonTapped()
    func stopPlaying()
}

extension DetailPresenter {
    fileprivate enum Constants {
        static let pageTitle: String = "Detail"
    }
}

final class DetailPresenter {
    
    unowned var view: DetailViewControllerProtocol!
    let interactor: DetailInteractorProtocol!
    let router: DetailRouterProtocol!
    let audioPlayer: AudioPlayer?
    private var isPlaying = false
    private var isFavorite = false
    private var track: Track?
    
    init(
        view: DetailViewControllerProtocol,
        interactor: DetailInteractorProtocol,
        router: DetailRouterProtocol
    ) {
        self.view = view
        self.interactor = interactor
        self.router = router
        audioPlayer = AudioPlayer()
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    
    func stopPlaying() {
        isPlaying = false
    }
    
    func addToFavorite() {
        interactor.addToFavorites(track: track!)
    }
    
    func removeFromFavorite() {
        interactor.removeFromFavorites(id: (track?.trackID!)!)
    }
    
    func isFavorite(id: Int) {
        isFavorite = interactor.isFavorite(id: id)
    }
    
    func viewWillAppear() {
        isFavorite(id: (track?.trackID) ?? 0)
        view.checkFavorite(isFavorite)
    }
    
    func viewDidLoad() {
        
        guard let track = view.getSource() else { return }
        self.track = track
        
        ImageDownloader.shared.image(
            track: track)
        { [weak self] data, error in
            guard let self else { return }
            guard let data, error == nil else { return }
            guard let image = UIImage(data: data) else { return }
            self.view.setImage(image)
        }
        view.setTitle(track.trackName ?? "")
        view.setTrackName(track.trackName ?? "Can't get trackName")
        view.setAlbumName(track.collectionName ?? "Can't get collectionName")
        view.setArtistName(track.artistName ?? "Can't get artistName")
        isFavorite(id: track.trackID!)
    }
    
    func playButtonTapped() {
        isPlaying.toggle()
        if let trackUrl = URL(string: track?.previewURL ?? "") {
            isPlaying ? audioPlayer?.playAudio(from: trackUrl) : audioPlayer?.pauseAudio()
        }
        view.playButtonTapped(isPlaying)
    }
    
    func favoriteButtonTapped() {
        if let id = track?.trackID {
            isFavorite(id: id)
        }
        view.favoriteButtonTapped(isFavorite)
    }
}


