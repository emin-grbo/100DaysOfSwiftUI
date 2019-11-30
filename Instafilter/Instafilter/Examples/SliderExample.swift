//
//  SliderExample.swift
//  Instafilter
//
//  Created by roblack on 11/28/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct SliderExample: View {
    
    @State private var blurAmount: CGFloat = 0

    var body: some View {
        
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
        },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
        }
        
        )
        
        
        
        return VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)

            Slider(value: blur, in: 0...20)
        }
    }
}

struct SliderExample_Previews: PreviewProvider {
    static var previews: some View {
        SliderExample()
    }
}
