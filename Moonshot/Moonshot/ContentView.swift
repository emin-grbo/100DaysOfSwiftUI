//
//  ContentView.swift
//  Moonshot
//
//  Created by roblack on 11/1/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
            Image("preview")
            .resizable()
            .aspectRatio(contentMode: .fit)
                .frame(width: geo.size.width)
//            .clipped()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
