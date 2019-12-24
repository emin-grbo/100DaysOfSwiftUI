//
//  SimultaniousGestureExample.swift
//  Flashzilla
//
//  Created by roblack on 12/18/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct SimultaniousGestureExample: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .onTapGesture {
                    print("Text tapped")
                }
        }
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    print("VStack tapped")
                }
        )
    }
}

