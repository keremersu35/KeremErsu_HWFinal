//
//  EmptyView.swift
//  SoundWave
//
//  Created by Kerem Ersu on 16.06.2023.
//

import UIKit

extension UITableView {
    func setEmptyView(icon: UIImage, text: String) {
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        
        let iconImageView = UIImageView(image: icon)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let textLabel = UILabel()
        textLabel.text = text
        textLabel.textAlignment = .center
        textLabel.textColor = UIColor(named: Constants.ColorNames.primary.rawValue)
        textLabel.numberOfLines = 0
        textLabel.font = .systemFont(ofSize: 17.0, weight: .semibold)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emptyView.addSubview(iconImageView)
        emptyView.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -40),
            iconImageView.widthAnchor.constraint(equalToConstant: 80),
            iconImageView.heightAnchor.constraint(equalToConstant: 80),
            
            textLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 16),
            textLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -16)
        ])
        
        backgroundView = emptyView
        separatorStyle = .none
    }
    
    func restore() {
        backgroundView = nil
        separatorStyle = .singleLine
    }
}
