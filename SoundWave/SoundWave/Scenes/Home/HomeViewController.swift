//
//  ViewController.swift
//  SoundWave
//
//  Created by Kerem Ersu on 7.06.2023.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func setupTableView()
    func reloadData()
    func showError(_ message: String)
    func showLoadingView()
    func hideLoadingView()
    func setTitle(_ title: String)
}

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    func setupTableView() {
        
    }
    
    func reloadData() {
        
    }
    
    func showError(_ message: String) {
        
    }
    
    func showLoadingView() {
        
    }
    
    func hideLoadingView() {
        
    }
    
    func setTitle(_ title: String) {
        
    }
}

