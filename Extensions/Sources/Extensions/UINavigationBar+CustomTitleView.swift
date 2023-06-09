//
//  UINavigationBar+CustomTitleView.swift
//  WordWise
//
//  Created by Kerem Ersu on 26.05.2023.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
public extension UINavigationBar {
    func setCustomTitleView(with color: UIColor, title: String? = nil, image: UIImage? = nil) {
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 35, height: 37)
        
        let label = UILabel()
        label.text = title
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.sizeToFit()
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: imageView.frame.width + label.frame.width, height: max(imageView.frame.height, label.frame.height)))
        
        imageView.frame.origin.x = 0
        imageView.center.y = containerView.frame.height / 2
        
        label.frame.origin.x = imageView.frame.width + 8
        label.center.y = containerView.frame.height / 2
        
        containerView.addSubview(imageView)
        containerView.addSubview(label)
        
        self.topItem?.titleView = containerView
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        appearance.shadowColor = .clear
        self.standardAppearance = appearance
        self.scrollEdgeAppearance = appearance
    }
}
