//
//  UIStoryBoard+GetVC.swift
//  WordWise
//
//  Created by Kerem Ersu on 30.05.2023.
//

import UIKit

public extension UIViewController {
    func getVC<T: UIViewController>(_ identifier: String) -> T? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier) as? T
    }
}
