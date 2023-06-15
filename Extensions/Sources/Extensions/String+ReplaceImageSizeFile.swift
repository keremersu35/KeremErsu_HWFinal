//
//  File.swift
//  
//
//  Created by Kerem Ersu on 13.06.2023.
//

import Foundation

public extension String {
    func replaceImageSize(size: Int) -> String {
        var components = self.components(separatedBy: "/")
        
        if let index = components.lastIndex(where: { $0.contains("100x100") }) {
            components[index] = "\(size)x\(size)bb.jpg"
        }
        
        return components.joined(separator: "/")
    }
}
