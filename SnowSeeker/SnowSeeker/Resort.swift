//
//  Resort.swift
//  SnowSeeker
//
//  Created by roblack on 12/29/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import Foundation

struct Resort: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]
    
    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
    
    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
}
