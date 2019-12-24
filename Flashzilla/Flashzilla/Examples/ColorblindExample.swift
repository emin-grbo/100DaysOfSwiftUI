//
//  ColorblindExample.swift
//  Flashzilla
//
//  Created by roblack on 12/24/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ColorblindExample: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }

            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? Color.black : Color.green)
        .foregroundColor(Color.white)
        .clipShape(Capsule())
    }
}
