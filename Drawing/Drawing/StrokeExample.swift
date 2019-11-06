//
//  StrokeExample.swift
//  Drawing
//
//  Created by roblack on 11/6/19.
//  Copyright © 2019 UndeadPixel. All rights reserved.
//

import SwiftUI

struct StrokeExample: View {
    var body: some View {
        VStack {
        Text("Hello World")
            .frame(width: 300, height: 300)
            .border(ImagePaint(image: Image("example"), scale: 0.2), width: 30)
            
            Capsule()
                .strokeBorder(ImagePaint(image: Image("example"), scale: 0.1), lineWidth: 20)
                .frame(width: 300, height: 200)
        }
    }
}

struct StrokeExample_Previews: PreviewProvider {
    static var previews: some View {
        StrokeExample()
    }
}
