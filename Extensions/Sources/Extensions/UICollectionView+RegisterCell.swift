//
//  UICollectionView+RegisterCell.swift
//  
//
//  Created by Kerem Ersu on 1.06.2023.
//

import Foundation

import Foundation
import UIKit

public extension UICollectionView {
    
    func register(cellType: UICollectionViewCell.Type) {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func dequeCell<T: UICollectionViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        guard let cell =
                dequeueReusableCell(
                    withReuseIdentifier: cellType.identifier,
                    for: indexPath) as? T else {
            fatalError("Error!")
        }
        return cell
    }
}
