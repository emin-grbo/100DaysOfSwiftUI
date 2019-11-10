//
//  HabitView.swift
//  iHabit
//
//  Created by roblack on 11/10/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct HabitView: View {
    
    var selectedItem: HabitItem
    @State var logTimes = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(selectedItem.title)
                .font(.system(size: 50, weight: .bold))
                .multilineTextAlignment(.leading)
            Text(selectedItem.description)
                .font(.system(size: 30))
            Text("\(selectedItem.logs)")
                .font(.system(size: 35))
            Stepper("Logged", value: $logTimes)
        }
    .padding()
        
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(selectedItem: HabitItem(title: "Test", description: "testSubtitle", logs: 0))
    }
}
