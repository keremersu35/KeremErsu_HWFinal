//
//  String+CapitalizeFirstLetter.swift
//  WordWise
//
//  Created by Kerem Ersu on 28.05.2023.
//

import Foundation

public extension String {
    func capitalizeFirstLetter() -> String {
        guard let firstCharacter = first else {
            return self
        }
        return firstCharacter.uppercased() + dropFirst()
    }
}
