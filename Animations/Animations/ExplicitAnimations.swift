//
//  ExplicitAnimations.swift
//  Animations
//
//  Created by roblack on 10/27/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ExplicitAnimations: View {
    
    @State var enabled = false
    
    var body: some View {
        
        ZStack{
            Color.purple.edgesIgnoringSafeArea(.all)
            Button("TAP ME") {
                self.enabled.toggle()
            }
            .padding(50)
            .background(enabled ? Color.blue : Color.orange)
            .clipShape(RoundedRectangle(cornerRadius: enabled ? 120 : 0))
            .foregroundColor(.white)
            .font(.system(size: 24, weight: .bold, design: .rounded))
            .animation(.default)
        }
    }
}

struct ExplicitAnimations_Previews: PreviewProvider {
    static var previews: some View {
        ExplicitAnimations()
    }
}
