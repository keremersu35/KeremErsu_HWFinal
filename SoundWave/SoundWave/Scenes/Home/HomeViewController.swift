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
    var typingTimer: Timer?
    var previousIndex: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
        searchTextField.delegate = self
        searchTextField.setLeftImage(image: UIImage(systemName: "magnifyingglass"))
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellType: TrackCell.self, indexPath: indexPath)
        if let track = presenter.getTrackCellModel(indexPath.row) {
            cell.setup(model: track)
            cell.isFavorite = presenter.isFavorite(id: (presenter.getTrack(indexPath.row)?.trackID)!)
            cell.playButtonTapped = {
                if self.previousIndex == indexPath.row && cell.isPlaying {
                    self.audioPlayer.pauseAudio()
                } else {
                    if let url = URL(string: track.previewUrl) {
                        if let previous = self.previousIndex {
                            let previousCell = tableView.cellForRow(at: IndexPath(row: previous, section: 0)) as! TrackCell
                            previousCell.isPlaying = false
                            previousCell.playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                        }
                        self.audioPlayer.pauseAudio()
                        self.audioPlayer.playAudio(from: url)
                    }
                }
                self.previousIndex = indexPath.row
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.audioPlayer.pauseAudio()
        presenter.didSelectRowAt(index: indexPath.row)
    }
}

extension HomeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        typingTimer?.invalidate()
    
        if let text = textField.text,
           let range = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: range, with: string)
            
            if !updatedText.isEmpty {
                typingTimer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { [weak self] timer in
                    self!.audioPlayer.pauseAudio()
                    self?.presenter.fetchData(query: updatedText)
                }
            }
        }
        return true
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
