//
//  ObjectWillChangeExample.swift
//  HotProspects
//
//  Created by roblack on 12/13/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ObjectWillChangeExample: View {
    
    @ObservedObject var updater = DelayedUpdater()

    var body: some View {
        Text("Value is: \(updater.value)")
    }
    
    class DelayedUpdater: ObservableObject {
//        @Published var value = 0
        
        // If we want to send the information on our own, without the published
        var value = 0 {
            willSet {
                objectWillChange.send()
            }
        }

        init() {
            for i in 1...10 {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                    self.value += 1
                }
            }
        }
    }
    
}
