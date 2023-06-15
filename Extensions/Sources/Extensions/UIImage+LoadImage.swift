//
//  UIImage+LoadImage.swift
//  
//
//  Created by Kerem Ersu on 13.06.2023.
//

import Foundation
import UIKit

public extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}
