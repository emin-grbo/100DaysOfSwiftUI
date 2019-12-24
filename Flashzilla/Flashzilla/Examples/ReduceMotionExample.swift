//
//  ReduceMotionExample.swift
//  Flashzilla
//
//  Created by roblack on 12/24/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ReduceMotionExample: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale: CGFloat = 1

    var body: some View {
        Text("Hello, World!")
            .scaleEffect(scale)
            .onTapGesture {
                if self.reduceMotion {
                    self.scale *= 1.5
                } else {
                    withAnimation {
                        self.scale *= 1.5
                    }
                }
            }
    }
}

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

// Optional example with animation using above code
struct OptionalAnimation: View {
    @State private var scale: CGFloat = 1

    var body: some View {
        Text("Hello, World!")
            .scaleEffect(scale)
            .onTapGesture {
                withOptionalAnimation {
                    self.scale *= 1.5
                }
            }
    }
}
