//
//  TimerExample.swift
//  Flashzilla
//
//  Created by roblack on 12/24/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct TimerExample: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0

    var body: some View {
        Text("Hello, World!")
            .onReceive(timer) { time in
                if self.counter == 5 {
                    self.timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }

                self.counter += 1
            }
    }
}

