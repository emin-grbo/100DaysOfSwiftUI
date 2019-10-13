//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by roblack on 10/13/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack() {
            Color.red.edgesIgnoringSafeArea(.all)
            HStack(spacing: 20) {
                Text("Hello World")
                Text("Second Text")
                Text("Turd Text")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
