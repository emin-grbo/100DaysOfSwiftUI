//
//  Bundle-decodable.swift
//  Moonshot
//
//  Created by roblack on 11/3/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to load file.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load data.")
        }
        
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle")
        }
        
        return loaded
    
    }
}
