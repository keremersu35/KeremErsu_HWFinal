//
//  TrackCell.swift
//  SoundWave
//
//  Created by Kerem Ersu on 8.06.2023.
//

import UIKit

final class TrackCell: UITableViewCell {

    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet private weak var coverImage: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    var playButtonTapped: (() -> Void)?
    var isPlaying = false
    var isFavorite = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setup(model: TrackCellModel) {
        nameLabel.text = model.trackName
        artistNameLabel.text = model.artistName
        let imageURL = URL(string: model.imageUrl)
        self.coverImage.loadImage(from: imageURL!)
        favoriteButton.setImage(UIImage(systemName: model.isFav ? "heart.fill" : "heart"), for: .normal)
    }
    
    @IBAction func favoriteButtonAction(_ sender: UIButton) {
         
    }
    
    @IBAction func playButtonAction(_ sender: UIButton) {
        playButtonTapped!()
        isPlaying.toggle()
        playButton.setImage(UIImage(systemName: isPlaying ? "pause.fill" : "play.fill"), for: .normal)
    }
    
    override func prepareForReuse() {
        coverImage.image = nil
        nameLabel.text = nil
        artistNameLabel.text = nil
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        isPlaying = false
    }
}
