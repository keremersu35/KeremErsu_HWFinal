//
//  TrackCell.swift
//  SoundWave
//
//  Created by Kerem Ersu on 8.06.2023.
//

import UIKit

protocol TrackCellProtocol: AnyObject {
    func setButtonImageAsPlay()
    func checkIsPlaying() -> Bool
    func setIsPlayingAsFalse()
    func setImage(_ image: UIImage)
    func setTrackName(_ name: String)
    func setArtistName(_ name: String)
}

final class TrackCell: UITableViewCell, TrackCellProtocol {

    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var coverImage: UIImageView!
    var playButtonTapped: (() -> Void)?
    private var isPlaying = false
    var cellPresenter: TrackCellPresenterProtocol! {
        didSet {
            cellPresenter.setup()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playButton.setImage(UIImage(systemName: Constants.ImageNames.play.rawValue), for: .normal)
    }
    
    @IBAction func playButtonAction(_ sender: UIButton) {
        playButtonTapped!()
        isPlaying.toggle()
        playButton.setImage(UIImage(systemName: isPlaying ? Constants.ImageNames.pause.rawValue :
            Constants.ImageNames.play.rawValue), for: .normal)
    }
    
    func setButtonImageAsPlay() {
        playButton.setImage(UIImage(systemName: Constants.ImageNames.play.rawValue), for: .normal)
    }
    
    func checkIsPlaying() -> Bool {
        isPlaying
    }
    
    func setIsPlayingAsFalse() {
        isPlaying = false
    }
    
    func setImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.coverImage.image = image
        }
    }
    
    func setTrackName(_ name: String) {
        nameLabel.text = name
    }
    
    func setArtistName(_ name: String) {
        artistNameLabel.text = name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImage.image = nil
        nameLabel.text = nil
        artistNameLabel.text = nil
        playButton.setImage(UIImage(systemName: Constants.ImageNames.play.rawValue), for: .normal)
        isPlaying = false
    }
}
