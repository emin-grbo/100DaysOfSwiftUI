//
//  RotationExample.swift
//  Flashzilla
//
//  Created by roblack on 12/18/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct RotationExample: View {
    @State private var currentAmount: Angle = .degrees(0)
    @State private var finalAmount: Angle = .degrees(0)

    var body: some View {
        Text("Hello, World!")
            .rotationEffect(currentAmount + finalAmount)
            .gesture(
                RotationGesture()
                    .onChanged { angle in
                        self.currentAmount = angle
                    }
                    .onEnded { angle in
                        self.finalAmount += self.currentAmount
                        self.currentAmount = .degrees(0)
                    }
            )
    }
}

