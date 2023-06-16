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
    func navigateToFavorites()
}

final class HomeViewController: BaseViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchTextField: UITextField!
    var presenter: HomePresenterProtocol!
    private let audioPlayer = AudioPlayer()
    private var typingTimer: Timer?
    private var previousIndex: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        searchTextField.delegate = self
        searchTextField.setLeftImage(image: UIImage(systemName: Constants.ImageNames.search.rawValue))
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellType: TrackCell.self, indexPath: indexPath)
        if let track = presenter.getTrackCellModel(indexPath.row) {
            cell.cellPresenter = TrackCellPresenter(view: cell, track: track)
            
            cell.playButtonTapped = {
                if self.previousIndex == indexPath.row && cell.checkIsPlaying() {
                    self.audioPlayer.pauseAudio()
                } else {
                    if let url = URL(string: track.previewUrl) {
                        if let previous = self.previousIndex  {
                            let previousCell = tableView.cellForRow(at: IndexPath(row: previous, section: 0)) as? TrackCell
                            previousCell?.setIsPlayingAsFalse()
                            previousCell?.setButtonImageAsPlay()
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
        
        typingTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] timer in
            self!.audioPlayer.pauseAudio()
            guard let searchText = textField.text else { return }
            self?.presenter.fetchData(query: searchText)
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
        self.showAlert("Error", "Error occured.")
    }
    
    func showLoadingView() {
        self.showLoading()
    }
    
    func hideLoadingView() {
        self.hideLoading()
    }
    
    @objc func navigateToFavorites() {
        audioPlayer.pauseAudio()
        presenter.navigateToFavorites()
    }
    
    func setTitle(_ title: String) {
        self.title = title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"),style: .plain, target: self, action: #selector(navigateToFavorites))
    }
}
