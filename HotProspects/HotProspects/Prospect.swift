//
//  Prospect.swift
//  HotProspects
//
//  Created by roblack on 12/15/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var dateAdded = Date()
    fileprivate(set) var isContacted = false
}


class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    static let saveKey = "SavedData"

    init() {
        if let savedPeople = FileManager().load(withName: Self.saveKey) {
            self.people = savedPeople
            return
        }
        self.people = []
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            FileManager().save(encoded, withName: Self.saveKey)
        }
    }
    
}


extension FileManager {
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    func save(_ userData: Data, withName name: String) {
        let url = getDocumentsDirectory().appendingPathComponent(name)
        
        do {
            try userData.write(to: url, options: .atomicWrite)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func load(withName name: String) -> [Prospect]? {
        let url = getDocumentsDirectory().appendingPathComponent(name)
        if let data = try? Data(contentsOf: url) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                return decoded
            }
        }
        return nil
    }
}
