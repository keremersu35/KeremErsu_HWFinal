//
//  LoadingView.swift
//  SoundWave
//
//  Created by Kerem Ersu on 7.06.2023.
//

import UIKit

final class LoadingView {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    static let shared = LoadingView()
    var blurView: UIVisualEffectView = UIVisualEffectView()
    
    private init() {
        configure()
    }
    
    func configure() {
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = UIWindow(frame: UIScreen.main.bounds).frame
        activityIndicator.center = blurView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        blurView.contentView.addSubview(activityIndicator)
    }
    
    func startLoading() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let mainWindow = windowScene.windows.first {
            mainWindow.addSubview(blurView)
        }
        blurView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        blurView.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
}
