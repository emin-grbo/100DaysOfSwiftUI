//
//  ContentView.swift
//  iHabit
//
//  Created by roblack on 11/10/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var habits = Habbits()
    
    @State private var showingAddItem = false
    
    var body: some View {
        
        NavigationView {
            List(habits.items) { habitItem in
                NavigationLink(destination: HabitView(habits: self.habits, selectedItem: habitItem)) {
                    HStack {
                        Text("\(habitItem.title)")
                        Text("\(habitItem.logs)")
                    }
                    }
            }
            .navigationBarTitle("iHabit")
            .navigationBarItems(trailing:
            Button(action: {
                self.showingAddItem = true
            }) {
                Text("Add item")
                    .foregroundColor(.white)
            })
        }
        .sheet(isPresented: $showingAddItem) {
            AddItemView(habits: self.habits)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}
