//
//  ContentView.swift
//  iHabit
//
//  Created by roblack on 11/10/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var habitItems: [HabitItem] = [HabitItem(title: "testTitle", description: "testSubtitle", logs: 1)]
    
    var body: some View {
        
        NavigationView {
            List(habitItems, id: \.title) { habitItem in
                    NavigationLink(destination: HabitView(selectedItem: habitItem)) {
                        Text("\(habitItem.title)")
                    }
            }
            .navigationBarTitle("iHabit")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
