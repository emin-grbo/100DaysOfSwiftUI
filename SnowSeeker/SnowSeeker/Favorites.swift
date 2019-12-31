//
//  Favorites.swift
//  SnowSeeker
//
//  Created by roblack on 12/31/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {
        
        if let encodedData = UserDefaults.standard.data(forKey: saveKey) {
            if let data = try? JSONDecoder().decode(Set<String>.self, from: encodedData) {
                resorts = data
                return
            }
        }
        self.resorts = []
        
        
//        let url = FileManager().getDocumentsDirectory().appendingPathComponent(saveKey)
//        if let data = try? Data(contentsOf: url) {
//            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
//                resorts = decoded
//                print("loaded")
//            }
//        } else {
//            self.resorts = []
//        }
//        self.resorts = []
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        
        if let data = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(data, forKey: saveKey)
        } else {
            fatalError("unable to save")
        }
        
        
//        let directory = FileManager().getDocumentsDirectory()
//
//        let url = directory.appendingPathComponent(saveKey)
//        if let data = try? JSONEncoder().encode(resorts) {
//            do {
//                try data.write(to: url, options: .atomicWrite)
//                print("saved")
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
    }
}


extension FileManager {

func getDocumentsDirectory() -> URL {
    // find all possible documents directories for this user
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    // just send back the first one, which ought to be the only one
    return paths[0]
}
}
