//
//  ContentView.swift
//  Drawing
//
//  Created by Emin Grbo on 05/11/2019.
//  Copyright © 2019 UndeadPixel. All rights reserved.
//

import SwiftUI

struct Arrow: Shape {
    
    var thichkness: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let triangle = Triangle()
        let rectangle = Rectangle()
        
        path.addPath(triangle.path(in: CGRect(x: 0,
                                              y: 0,
                                              width: thichkness,
                                              height: rect.height / 2)))
        path.addPath(rectangle.path(in: CGRect(x: rect.width / 2 - rect.width / 4,
                                               y: rect.height / 2,
                                               width: thichkness / 2,
                                               height: rect.height / 3)))
        return path
    }
    
}

struct ColorCyclingRect : View {
    
    var steps = 300
    var amount = 0.0
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                .inset(by: CGFloat(value))
                .strokeBorder(LinearGradient(gradient: Gradient(colors:
                    [self.color(for: value, brightness: 1),
                    self.color(for: value, brightness: 2)]),
                                             startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)),
                              lineWidth: 5)
            }
        }
    .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        if targetHue > 1 {
            targetHue -= 1
        }
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}


struct ContentView: View {
    
    @State var thick: CGFloat = 100
    @State var lineThick: CGFloat = 10
    
    @State private var colorCycle = 0.0

    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                ColorCyclingRect(amount: self.colorCycle)
                    .edgesIgnoringSafeArea(.top)
        Arrow(thichkness: thick)
            .stroke(Color.white, style: StrokeStyle(lineWidth: lineThick, lineCap: .round))
            .frame(width: thick, height: 300)
            
            .overlay(
              Arrow(thichkness: thick)
            ).foregroundColor(Color.green)
            }
            Spacer()
//            HStack {
                Text("Arrow width")
                Slider(value: $thick, in: 20...300)
                .padding()
                Text("Line thickness")
                Slider(value: $lineThick, in: 1...30)
                .padding()
//            }
            .padding()
            
//            HStack {
                Text("Coooloooorz")
                Slider(value: $colorCycle)
                .padding()
//            }
//            .padding()
            
            
        }
    }

}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environment(\.colorScheme, .dark)
    }
}
#endif
