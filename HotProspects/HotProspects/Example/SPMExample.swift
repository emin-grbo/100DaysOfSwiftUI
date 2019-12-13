//
//  SPMExample.swift
//  HotProspects
//
//  Created by roblack on 12/13/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI
import SamplePackage

let possibleNumbers = Array(1...60)

var results: String {
    let selected = possibleNumbers.random(7).sorted()
    let strings = selected.map(String.init)
    return strings.joined(separator: ", ")
}

struct SPMExample: View {
    var body: some View {
        Text(results)
    }
}
