//
//  Astronauts.swift
//  Moonshot
//
//  Created by roblack on 11/3/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import Foundation

struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
