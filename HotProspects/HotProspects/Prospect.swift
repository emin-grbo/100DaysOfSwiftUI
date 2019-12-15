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
    fileprivate(set) var isContacted = false
}


class Prospects: ObservableObject {
    @Published var people: [Prospect]

    init() {
        self.people = []
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
    }
    
}
