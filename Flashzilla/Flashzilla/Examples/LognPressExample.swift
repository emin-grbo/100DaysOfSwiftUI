//
//  LognPressExample.swift
//  Flashzilla
//
//  Created by roblack on 12/18/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct LognPressExample: View {
    var body: some View {
        Text("Hello, World!")
        .onLongPressGesture(minimumDuration: 1, pressing: { inProgress in
            print("In progress: \(inProgress)!")
        }) {
            print("Long pressed!")
        }
    }
}
