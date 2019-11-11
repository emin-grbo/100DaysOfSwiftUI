//
//  HabitView.swift
//  iHabit
//
//  Created by roblack on 11/10/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct HabitView: View {
    
    @ObservedObject var habits: Habbits
    @State var selectedItem: HabitItem
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            Text(selectedItem.title)
                .font(.system(size: 50, weight: .bold))
                .multilineTextAlignment(.center)
            Text(selectedItem.description)
                .font(.system(size: 30))
            .multilineTextAlignment(.center)
            Text("\(selectedItem.logs)")
                .font(.system(size: 35))
            Stepper("Logged", onIncrement: {
                self.selectedItem.logs += 1
                self.saveHabit()
            }, onDecrement: {
                self.selectedItem.logs -= 1
                self.saveHabit()
            })
            .labelsHidden()
            Spacer()
        }
        .padding()
    }
    
    func saveHabit() {
        guard let index = habits.items.firstIndex(where: {$0.id == selectedItem.id }) else { return }
        habits.items[index].logs = selectedItem.logs
    }
}
