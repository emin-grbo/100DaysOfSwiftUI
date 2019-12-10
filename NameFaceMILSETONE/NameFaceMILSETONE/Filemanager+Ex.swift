//
//  Filemanager+Ex.swift
//  NameFaceMILSETONE
//
//  Created by roblack on 12/10/19.
//  Copyright © 2019 roblack. All rights reserved.
//
import SwiftUI
import Foundation

extension FileManager {
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func savePhoto(_ image: UIImage, withName name: String) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {return}
        let url = getDocumentsDirectory().appendingPathComponent(name)
        
        do {
            try imageData.write(to: url, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadPhoto(withName name: String) -> UIImage? {
        let url = getDocumentsDirectory().appendingPathComponent(name)
        if let loadedImageData = try? Data(contentsOf: url) {
            return UIImage(data: loadedImageData)
        }
        return nil
    }
}
