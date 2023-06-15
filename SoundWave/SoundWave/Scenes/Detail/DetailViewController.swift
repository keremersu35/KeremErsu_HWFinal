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
    func checkFavoriteStatus(_ isFav: Bool)
}

final class DetailViewController: BaseViewController {

    var presenter: DetailPresenterProtocol!
    var source: Track?
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var playedTimeLabel: UILabel!
    @IBOutlet private weak var remainedTimeLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var progressBar: UIProgressView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var coverImageView: UIImageView!
    var timer: Timer?
    var playbackTime: TimeInterval = 0
    let rotationAnimationKey = "rotationAnimation"
    var isPlaying = false
    var isFav = false
    private let audioPlayer = AudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        presenter.isFavorite(id: (source?.trackID)!)
        progressBar.progress = 0
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        let imageURL = URL(string: (source?.artworkUrl100?.replaceImageSize(size: 500))!)
        self.coverImageView.loadImage(from: imageURL!)
        nameLabel.text = source?.trackName
        artistNameLabel.text = source?.artistName
    }
    
    @IBAction func playButtonAction(_ sender: UIButton) {
        isPlaying ? stopMusic() : playMusic()
        let trackUrl = URL(string: source?.previewURL ?? "")
        isPlaying ? audioPlayer.playAudio(from: trackUrl!) : audioPlayer.pauseAudio()
        playButton.setImage(UIImage(systemName: isPlaying ? "pause.fill" : "play.fill"), for: .normal)
    }
    
    func playMusic() {
        isPlaying = true
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        startProgressBar()
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0)
        rotationAnimation.duration = 10
        rotationAnimation.repeatCount = Float.infinity
        coverImageView.layer.add(rotationAnimation, forKey: rotationAnimationKey)
    }
    
    @IBAction func FavoriteButtonAction(_ sender: UIButton) {
        isFav.toggle()
        isFav ? presenter.addToFavorite(track: source!)
        : presenter.removeFromFavorite(id: (source?.trackID!)!)
        self.favoriteButton.setImage(UIImage(systemName: isFav ? "heart.fill" : "heart"), for: .normal)
        
    }
    
    func startProgressBar() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.playbackTime += 1.0
            let progress = Float(self.playbackTime / 30)
            self.progressBar.progress = progress

            if progress >= 1.0 {
                self.timer?.invalidate()
            }
        }
    }
    
    func stopMusic() {
        isPlaying = false
        timer?.invalidate()
        coverImageView.layer.removeAnimation(forKey: rotationAnimationKey)
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    
    func checkFavoriteStatus(_ isFav: Bool) {
        self.isFav = isFav
        self.favoriteButton.setImage(UIImage(systemName: isFav ? "heart.fill" : "heart"), for: .normal)
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func getSource() -> Track? {
        return source
    }
}
