//
//  HapticsExample.swift
//  Flashzilla
//
//  Created by roblack on 12/18/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct HapticsExample: View {
    
    var body: some View {
        Text("Hello, World!")
        .onTapGesture(perform: simpleSuccess)
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

struct HapticsExample_Previews: PreviewProvider {
    static var previews: some View {
        HapticsExample()
    }
}
