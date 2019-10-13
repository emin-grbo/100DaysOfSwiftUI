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
            AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center).edgesIgnoringSafeArea(.all)
            HStack {
                Group{
                Image(systemName: "pencil").resizable()
                Image(systemName: "car").resizable()
                Image(systemName: "flag").resizable()
                    
                }
                .foregroundColor(Color.white)
            }
            .frame(width: 300, height: 100, alignment: .center)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
