//
//  TestViewq.swift
//  MultiplicationTable
//
//  Created by roblack on 11/2/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct TestView: View {
    
    @State private var favoriteColor = 0
    var colors = ["Red", "Green", "Blue"]

    var body: some View {
        VStack {
            Picker(selection: $favoriteColor, label: Text("What is your favorite color?")) {
                ForEach(0..<colors.count) { index in
                    Text(self.colors[index]).tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle())
//            .label(Text("test"))
            Text("Value: \(colors[favoriteColor])")
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
