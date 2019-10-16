//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by roblack on 10/16/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 250, height: 60, alignment: .center)
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.purple)
            .clipShape(Capsule())
    }
}

extension View {
    func title() -> some View {
        self.modifier(Title())
    }
}


struct TextTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func textTitle() -> some View {
        self.modifier(TextTitle())
    }
}


struct ContentView: View {
    var body: some View {
        ZStack {
            VStack (spacing: 90) {
                Text("Now that's a title")
                    .textTitle()
                Text("Hello World")
                    .title()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.orange).edgesIgnoringSafeArea(.all)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
