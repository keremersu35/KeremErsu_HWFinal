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
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var coverImage: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    var playButtonTapped: (() -> Void)?
    private var isPlaying = false
    
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
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL!) {
                DispatchQueue.main.async {
                    self.coverImage.image = UIImage(data: data)
                }
            }
        }
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
    }
}
