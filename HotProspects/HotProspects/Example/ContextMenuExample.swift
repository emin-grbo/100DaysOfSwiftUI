//
//  ContextMenuExample.swift
//  HotProspects
//
//  Created by roblack on 12/13/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ContextMenuExample: View {
    @State private var backgroundColor = Color.red

    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .background(backgroundColor)

            Text("Change Color")
                .padding()
                .contextMenu {
                    Button(action: {
                        self.backgroundColor = .red
                    }) {
                        Text("Red")
                        Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(backgroundColor)
                    }

                    Button(action: {
                        self.backgroundColor = .green
                    }) {
                        Text("Green")
                        Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    }

                    Button(action: {
                        self.backgroundColor = .blue
                    }) {
                        Text("Blue")
                        Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                    }
                }
        }
    }
}
