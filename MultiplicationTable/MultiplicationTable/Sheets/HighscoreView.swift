//
//  HighscoreView.swift
//  MultiplicationTable
//
//  Created by roblack on 11/4/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct HighscoreView: View {
    
    @State var scores = ["1x", "2x", "3x", "4x", "5x", "6x", "7x", "8x", "9x", "10x"]
    
    var body: some View {
        
        return VStack {
            Spacer(minLength: 40)
            Text("Highscores").font(.headline)
            List(scores, id: \.self) { score in
                HStack {
                Text("\(score)")
                }
            }
        }
    }
}

struct HighscoreView_Previews: PreviewProvider {
    static var previews: some View {
        HighscoreView()
    }
}
