//
//  Arc.swift
//  Drawing
//
//  Created by Emin Grbo on 05/11/2019.
//  Copyright © 2019 UndeadPixel. All rights reserved.
//

import SwiftUI

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var insetAmount: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        
        let rotationAdjustment = Angle.degrees(90)
        let modStart = startAngle - rotationAdjustment
        let modEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modStart, endAngle: modEnd, clockwise: !clockwise)

        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct ArcExample: View {
    var body: some View {
        Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
            .stroke(Color.blue, lineWidth: 10)
            .frame(width: 300, height: 300)
    }
}

struct ArcExample_Previews: PreviewProvider {
    static var previews: some View {
        ArcExample()
    }
}
