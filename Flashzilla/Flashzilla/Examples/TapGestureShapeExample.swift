//
//  TapGestureShapeExample.swift
//  Flashzilla
//
//  Created by roblack on 12/18/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct TapGestureShapeExample: View {
    var body: some View {
       VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World")
        }
//        .allowsHitTesting(false)
        .contentShape(Rectangle())
        .onTapGesture {
            print("VStack tapped!")
        }
    }
}

struct TapGestureShapeExample_Previews: PreviewProvider {
    static var previews: some View {
        TapGestureShapeExample()
    }
}
