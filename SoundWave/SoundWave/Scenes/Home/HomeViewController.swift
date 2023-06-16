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
        
        checkEmptyState(searchText: searchTextField.text ?? "")
        presenter.viewDidLoad()
        setAccessiblityIdentifiers()
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
            self?.checkEmptyState(searchText: searchText)
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
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: Constants.ColorNames.primary.rawValue)!]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: Constants.ImageNames.favFill.rawValue),style: .plain, target: self, action: #selector(navigateToFavorites))
    }
}

extension HomeViewController {
    
    func setAccessiblityIdentifiers() {
        searchTextField.accessibilityIdentifier = "searchTextField"
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "navBarFavoriteButton"
    }
    
    func checkEmptyState(searchText: String) {
        if presenter.numberOfItems() == 0 && !searchText.isEmpty {
            tableView.setEmptyView(
                icon: UIImage(systemName: Constants.ImageNames.empty.rawValue)!,
                text: "There is no content with your query"
            )
        }
        else if presenter.numberOfItems() == 0 && searchText.isEmpty {
            tableView.setEmptyView(
                icon: UIImage(systemName: Constants.ImageNames.music.rawValue)!,
                text: "Search for the\n content you're looking for"
            )
        } else {
            tableView.restore()
        }
    }
}
