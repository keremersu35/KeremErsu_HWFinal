//
//  HomeViewController.swift
//  SoundWave
//
//  Created by Kerem Ersu on 8.06.2023.
//

import UIKit
import Extensions

protocol HomeViewControllerProtocol: AnyObject {
    func setupTableView()
    func reloadData()
    func showError(_ message: String)
    func showLoadingView()
    func hideLoadingView()
    func setTitle(_ title: String)
}

final class HomeViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchTextField: UITextField!
    var presenter: HomePresenterProtocol!
    private let audioPlayer = AudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
        searchTextField.setLeftImage(image: UIImage(systemName: "magnifyingglass"))
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellType: TrackCell.self, indexPath: indexPath)
        if let track = presenter.getTrack(indexPath.row) {
            let model = TrackCellModel (
                trackName: track.trackName!,
                artistName: track.artistName!,
                imageUrl: track.artworkUrl100!,
                previewUrl: track.previewURL ?? ""
            )
            cell.setup(model: model)
            cell.playButtonTapped = {
                if let url = URL(string: model.previewUrl) {
                    self.audioPlayer.pauseAudio()
                    self.audioPlayer.playAudio(from: url)
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: TrackCell.self)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ message: String) {
        
    }
    
    func showLoadingView() {
        self.showLoading()
    }
    
    func hideLoadingView() {
        self.hideLoading()
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
}
