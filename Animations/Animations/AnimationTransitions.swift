//
//  AnimationTransitions.swift
//  Animations
//
//  Created by roblack on 10/27/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI


struct CornerRotationModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor)
        .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotationModifier(amount: -90, anchor: .topLeading),
                  identity: CornerRotationModifier(amount: 0, anchor: .topLeading))
    }
}

struct AnimationTransitions: View {
    
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation{
                self.isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .pivot))
            }
        }
    }
}

struct AnimationTransitions_Previews: PreviewProvider {
    static var previews: some View {
        AnimationTransitions()
    }
}
