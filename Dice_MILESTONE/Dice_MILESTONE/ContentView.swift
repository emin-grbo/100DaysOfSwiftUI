//
//  ContentView.swift
//  Dice_MILESTONE
//
//  Created by roblack on 12/29/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var diceValues = DiceValues()
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(named: "diceBlu")
      UITabBar.appearance().backgroundImage = UIImage()
    }
    
    var body: some View {
        TabView {
            DiceRollView()
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
            }
            DiceHistoryView()
            .tabItem {
                    Image(systemName: "square.stack.fill")
            }
        }
        .edgesIgnoringSafeArea(.top)
        .accentColor(Color.white)
        .environmentObject(diceValues)
    }

    
}

// Used for testing but had to add one to assets to be able to use also as UIColor
extension Color {
init(_ hex: Int, opacity: Double = 1.0) {
    let red = Double((hex & 0xff0000) >> 16) / 255.0
    let green = Double((hex & 0xff00) >> 8) / 255.0
    let blue = Double((hex & 0xff) >> 0) / 255.0
    self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
}
}
