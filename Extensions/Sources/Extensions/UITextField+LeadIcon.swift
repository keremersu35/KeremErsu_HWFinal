//
//  UITextField+LeadIcon.swift
//  WordWise
//
//  Created by Kerem Ersu on 27.05.2023.
//

import Foundation
import UIKit

public extension UITextField {
    func setLeftImage(image: UIImage?, tintColor: UIColor? = nil) {
        let imageView = UIImageView(frame: CGRect(x: 8, y: 0, width: 28, height: 28))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = tintColor ?? .placeholderText
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 28))
        view.addSubview(imageView)
        
        leftViewMode = .always
        leftView = view
    }
}
