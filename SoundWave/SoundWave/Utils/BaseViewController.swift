//
//  BaseViewController.swift
//  SoundWave
//
//  Created by Kerem Ersu on 7.06.2023.
//

import UIKit

enum SnackbarAnimation {
    case fade
    case slide
    case scale
}

enum SnackbarPosition {
    case top
    case bottom
}

class BaseViewController: UIViewController, LoadingShowable {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(_ title: String, _ message: String, completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showSnackbar(message: String, position: SnackbarPosition = .bottom, icon: UIImage? = nil, animation: SnackbarAnimation = .fade) {
        let snackbarHeight: CGFloat = 50
        let snackbarSpacing: CGFloat = 16
        let iconSize: CGFloat = 24
        let animationDuration: TimeInterval = 0.3
        let displayDuration: TimeInterval = 2
        
        let snackbarView = UIView()
        snackbarView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        snackbarView.layer.cornerRadius = snackbarHeight / 2
        snackbarView.translatesAutoresizingMaskIntoConstraints = false
        
        let messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.font = .systemFont(ofSize: 14)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let iconImageView = UIImageView(image: icon)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        snackbarView.addSubview(messageLabel)
        snackbarView.addSubview(iconImageView)
        
        view.addSubview(snackbarView)
        
        let snackbarBottomConstraint: NSLayoutConstraint
        if position == .top {
            snackbarBottomConstraint = snackbarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: snackbarSpacing)
        } else {
            snackbarBottomConstraint = snackbarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -snackbarSpacing)
        }
        
        NSLayoutConstraint.activate([
            snackbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: snackbarSpacing),
            snackbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -snackbarSpacing),
            snackbarBottomConstraint,
            snackbarView.heightAnchor.constraint(equalToConstant: snackbarHeight),
            
            iconImageView.leadingAnchor.constraint(equalTo: snackbarView.leadingAnchor, constant: snackbarSpacing),
            iconImageView.centerYAnchor.constraint(equalTo: snackbarView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: iconSize),
            iconImageView.heightAnchor.constraint(equalToConstant: iconSize),
            
            messageLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: snackbarSpacing),
            messageLabel.trailingAnchor.constraint(equalTo: snackbarView.trailingAnchor, constant: -snackbarSpacing),
            messageLabel.topAnchor.constraint(equalTo: snackbarView.topAnchor, constant: snackbarSpacing),
            messageLabel.bottomAnchor.constraint(equalTo: snackbarView.bottomAnchor, constant: -snackbarSpacing)
        ])
        
        var initialTransform: CGAffineTransform
        
        switch animation {
        case .fade:
            snackbarView.alpha = 0
            initialTransform = .identity
        case .slide:
            snackbarView.alpha = 1
            initialTransform = CGAffineTransform(translationX: 0, y: snackbarHeight)
        case .scale:
            snackbarView.alpha = 1
            snackbarView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            initialTransform = .identity
        }
        
        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            snackbarView.alpha = 1
            snackbarView.transform = initialTransform
        }, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + displayDuration) {
            UIView.animate(withDuration: animationDuration, animations: {
                snackbarView.alpha = 0
                switch animation {
                case .fade:
                    snackbarView.transform = .identity
                case .slide:
                    snackbarView.transform = CGAffineTransform(translationX: 0, y: snackbarHeight)
                case .scale:
                    snackbarView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                }
            }) { _ in
                snackbarView.removeFromSuperview()
            }
        }
    }
}
