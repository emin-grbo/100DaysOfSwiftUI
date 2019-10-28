//
//  AnimatingGestures.swift
//  Animations
//
//  Created by roblack on 10/27/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct AnimatingGestures: View {

    @State var dragAmount = CGSize.zero
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
        .frame(width: 300, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .offset(dragAmount)
        .shadow(radius: 20)
        .gesture(
            DragGesture()
                .onChanged { self.dragAmount = $0.translation }
                .onEnded { _ in
                    withAnimation(.spring()) {
                    self.dragAmount = .zero
                    }
            }
        )
//            .animation(.spring())
    }
}

struct AnimatingGestures_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingGestures()
    }
}
