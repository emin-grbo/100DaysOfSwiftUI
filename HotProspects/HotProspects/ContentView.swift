//
//  ContentView.swift
//  HotProspects
//
//  Created by roblack on 12/12/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    var prospects = Prospects()
    
    var body: some View {
      TabView {
        ProspectsView(filter: .none)
               .tabItem {
                   Image(systemName: "person.3")
                   Text("Everyone")
               }
        ProspectsView(filter: .contacted)
               .tabItem {
                   Image(systemName: "checkmark.circle")
                   Text("Contacted")
               }
           ProspectsView(filter: .uncontacted)
               .tabItem {
                   Image(systemName: "questionmark.diamond")
                   Text("Uncontacted")
               }
           MeView()
               .tabItem {
                   Image(systemName: "person.crop.square")
                   Text("Me")
               }
        
       }
        .environmentObject(prospects)
    }
}


