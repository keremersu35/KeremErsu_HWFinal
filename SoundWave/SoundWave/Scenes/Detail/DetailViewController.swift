//
//  DetailViewController.swift
//  SoundWave
//
//  Created by Kerem Ersu on 8.06.2023.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func setTitle(_ title: String)
    func setNewsTitle(_ text: String)
    func setNewsDetail(_ text: String)
    func setNewsAuthor(_ text: String)
    func setNewsImage(_ image: UIImage)
    func getSource() -> Track?
}

final class DetailViewController: BaseViewController {

    var presenter: DetailPresenterProtocol!
    var source: Track?
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    let rotationAnimationKey = "rotationAnimation"
    var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        let imageURL = URL(string: (source?.artworkUrl100)!)
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL!) {
                DispatchQueue.main.async {
                    self.coverImageView.image = UIImage(data: data)
                }
            }
        }
        nameLabel.text = source?.trackName
        artistNameLabel.text = source?.artistName
    }
    
    @IBAction func playButtonAction(_ sender: UIButton) {
        isPlaying ? stopMusic() : playMusic()
        playButton.setImage(UIImage(systemName: isPlaying ? "pause.fill" : "play.fill"), for: .normal)
    }
    
    func playMusic() {
        
        isPlaying = true
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0)
        rotationAnimation.duration = 10
        rotationAnimation.repeatCount = Float.infinity
        coverImageView.layer.add(rotationAnimation, forKey: rotationAnimationKey)
    }
    
    func stopMusic() {
        isPlaying = false
        coverImageView.layer.removeAnimation(forKey: rotationAnimationKey)
    }
}

extension DetailViewController: DetailViewControllerProtocol {
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setNewsTitle(_ text: String) {
        
    }
    
    func setNewsDetail(_ text: String) {
        
    }
    
    func setNewsAuthor(_ text: String) {
        
    }
    
    func setNewsImage(_ image: UIImage) {
        DispatchQueue.main.async {
            
        }
    }
    
    func getSource() -> Track? {
        return source
    }
}
