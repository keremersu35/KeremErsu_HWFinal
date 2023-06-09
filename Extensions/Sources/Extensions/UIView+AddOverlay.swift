//
//  UIView+AddOverlay.swift
//  
//
//  Created by Kerem Ersu on 1.06.2023.
//

import UIKit

extension UIView {
    
    public func addoverlay(color: UIColor = .black,alpha : CGFloat = 0.4) {
        let overlay = UIView()
        overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        overlay.frame = bounds
        overlay.backgroundColor = color
        overlay.alpha = alpha
        addSubview(overlay)
    }
}
