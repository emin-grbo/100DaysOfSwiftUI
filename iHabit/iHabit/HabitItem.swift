//
//  HabitItem.swift
//  iHabit
//
//  Created by roblack on 11/10/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import Foundation

struct HabitItem: Identifiable, Codable {
    let id = UUID()
    let title: String
    let description: String
    var logs: Int
}

class Habbits: ObservableObject {
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "items") {
            if let savedItems = try? JSONDecoder().decode([HabitItem].self, from: items) {
                self.items = savedItems
                return
            }
        }
        self.items = []
    }
    
    @Published var items: [HabitItem] {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
}
