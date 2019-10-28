//
//  ContentView.swift
//  Animations
//
//  Created by roblack on 10/27/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var animationAmount = 0.0
    
    var body: some View {
        
        ZStack{
            Color.purple.edgesIgnoringSafeArea(.all)
        Button("TAP ME") {
            withAnimation(.interpolatingSpring(stiffness: 20, damping: 5)) {
                self.animationAmount += 360
            }
        }
    .padding(50)
    .background(Color.blue)
    .clipShape(Circle())
    .foregroundColor(.white)
        .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 5)
            )
    .shadow(radius: 20)
    .font(.system(size: 24, weight: .bold, design: .rounded))
    .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0.2))
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
