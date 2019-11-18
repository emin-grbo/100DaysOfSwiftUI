//
//  PushButtonBindingExample.swift
//  Bookworm
//
//  Created by roblack on 11/18/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool

    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]

    var body: some View {
        Button(title) {
            self.isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}


struct PushButtonBindingExample: View {
    @State private var rememberMe = false

    var body: some View {
        VStack {
            PushButton(title: "Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
        }
    }
}

struct PushButtonBindingExample_Previews: PreviewProvider {
    static var previews: some View {
        PushButtonBindingExample()
    }
}
