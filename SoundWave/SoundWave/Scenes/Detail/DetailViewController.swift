//
//  DetailViewController.swift
//  SoundWave
//
//  Created by Kerem Ersu on 8.06.2023.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func setTitle(_ title: String)
    func getSource() -> Track?
    func setImage(_ image: UIImage)
    func setTrackName(_ name: String)
    func setAlbumName(_ name: String)
    func setArtistName(_ name: String)
    func favoriteButtonTapped(_ isFavorite: Bool)
    func checkFavorite(_ isFavorite: Bool)
    func playButtonTapped(_ isPlaying: Bool)
}

final class DetailViewController: BaseViewController {

    var presenter: DetailPresenterProtocol!
    var source: Track?
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var playedTimeLabel: UILabel!
    @IBOutlet private weak var remainedTimeLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var albumNameLabel: UILabel!
    @IBOutlet private weak var progressBar: UIProgressView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var coverImageView: UIImageView!
    private var timer: Timer?
    private var playbackTime: TimeInterval = 0
    private let rotationAnimationKey = "rotationAnimation"
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAccessiblityIdentifiers()
        presenter.viewDidLoad()
        playButton.setImage(UIImage(systemName: Constants.ImageNames.play.rawValue), for: .normal)
    }
    
    @IBAction func playButtonAction(_ sender: UIButton) {
        presenter.playButtonTapped()
    }
    
    func playMusic() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        startProgressBar()
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0)
        rotationAnimation.duration = 10
        rotationAnimation.repeatCount = Float.infinity
        coverImageView.layer.add(rotationAnimation, forKey: rotationAnimationKey)
    }
    
    @IBAction func FavoriteButtonAction(_ sender: UIButton) {
        presenter.favoriteButtonTapped()
    }
    
    func startProgressBar() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.playbackTime += 1.0
            self.playedTimeLabel.text = self.playbackTime >= 10 ? "00:\(Int(self.playbackTime))" : "00:0\(Int(self.playbackTime))"
            let remainingTime = 30 - Int(self.playbackTime)
            self.remainedTimeLabel.text = self.playbackTime > 20 ? "00:0\(remainingTime)" : "00:\(remainingTime)"
            let progress = Float(self.playbackTime / 30)
            self.progressBar.progress = progress
            
            if progress >= 1.0 {
                self.stopMusic()
                self.presenter.stopPlaying()
            }
        }
    }
    
    func stopMusic() {
        timer?.invalidate()
        progressBar.progress = 0
        coverImageView.layer.removeAnimation(forKey: rotationAnimationKey)
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    
    func favoriteButtonTapped(_ isFavorite: Bool) {
        if isFavorite {
            self.showAlert("Are You Sure?", "This track will be removed from favorite list.") {
                self.presenter.removeFromFavorite()
                self.favoriteButton.setImage(UIImage(systemName: Constants.ImageNames.fav.rawValue), for: .normal)
            }
        } else {
            self.presenter.addToFavorite()
            self.favoriteButton.setImage(UIImage(systemName: Constants.ImageNames.favFill.rawValue), for: .normal)
        }
    }
    
    func checkFavorite(_ isFavorite: Bool) {
        self.favoriteButton.setImage(UIImage(systemName: isFavorite ? Constants.ImageNames.favFill.rawValue : Constants.ImageNames.fav.rawValue), for: .normal)
    }
    
    func playButtonTapped(_ isPlaying: Bool) {
        isPlaying ? playMusic() : stopMusic()
        playButton.setImage(UIImage(systemName: isPlaying ? Constants.ImageNames.pause.rawValue :
        Constants.ImageNames.play.rawValue), for: .normal)
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func getSource() -> Track? {
        return source
    }
    
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.coverImageView.image = image
        }
    }
     
    func setTrackName(_ name: String) {
        self.nameLabel.text = name
    }
    
    func setArtistName(_ name: String) {
        self.artistNameLabel.text = name
    }
    
    func setAlbumName(_ name: String) {
        self.albumNameLabel.text = name
    }
}

extension DetailViewController {
    
    func setAccessiblityIdentifiers() {

        playButton.accessibilityIdentifier = "playButton"
        playedTimeLabel.accessibilityIdentifier = "playedTimeLabel"
        remainedTimeLabel.accessibilityIdentifier = "remainedTimeLabel"
        favoriteButton.accessibilityIdentifier = "favoriteButton"
        albumNameLabel.accessibilityIdentifier = "albumNameLabel"
        progressBar.accessibilityIdentifier = "progressBar"
        nameLabel.accessibilityIdentifier = "nameLabel"
        artistNameLabel.accessibilityIdentifier = "artistNameLabel"
        coverImageView.accessibilityIdentifier = "coverImageView"
    }
}
