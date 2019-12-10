//
//  Filemanager+Ex.swift
//  FriendFace_MILESTONE
//
//  Created by roblack on 12/10/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import Foundation

extension FileManager {
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func save(_ string: String, withName name: String) {
        let url = getDocumentsDirectory().appendingPathComponent(name)
        
        do {
            try string.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func load(withName name: String) -> String? {
        
        let url = getDocumentsDirectory().appendingPathComponent(name)
        return try? String(contentsOf: url)
    }
}
