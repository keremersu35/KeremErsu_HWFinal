//
//  File.swift
//  
//
//  Created by Kerem Ersu on 1.06.2023.
//

import UIKit

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

public extension UITableView {
    
    func register(cellType: UITableViewCell.Type) {
        register(UINib(nibName: cellType.identifier, bundle: nil), forCellReuseIdentifier: cellType.identifier)
    }
    
    func dequeueCell<T: UITableViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        guard let cell =
                dequeueReusableCell(
                    withIdentifier: cellType.identifier,
                    for: indexPath) as? T else {
            fatalError("Error!")
        }
        return cell
    }
}
