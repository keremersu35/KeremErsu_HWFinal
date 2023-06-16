//
//  File.swift
//  
//
//  Created by Kerem Ersu on 15.06.2023.
//

import Foundation

public extension String {
    func convertingTurkishCharactersToEnglish() -> String {
        let turkishCharacters = ["ı", "İ", "ğ", "Ğ", "ü", "Ü", "ş", "Ş", "ö", "Ö", "ç", "Ç"]
        let englishEquivalents = ["i", "I", "g", "G", "u", "U", "s", "S", "o", "O", "c", "C"]
        
        var convertedString = self
        for (index, turkishChar) in turkishCharacters.enumerated() {
            let englishChar = englishEquivalents[index]
            convertedString = convertedString.replacingOccurrences(of: turkishChar, with: englishChar)
        }
        
        return convertedString
    }
}
