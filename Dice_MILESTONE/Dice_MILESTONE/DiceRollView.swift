//
//  DiceRollView.swift
//  Dice_MILESTONE
//
//  Created by roblack on 12/29/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct DiceRollView: View {
    
    @State private var diceValue = Int.random(in: 1...6)
    @EnvironmentObject var diceValues: DiceValues
    
    var body: some View {
        ZStack {
            Color(0x011729)
        VStack {
            Spacer()
        Image("\(diceValue)")
            Spacer()
        Button("Roll The Dice") {
            self.diceRoll()
        }
            .padding()
        .foregroundColor(Color.black)
        .background(Color.white)
        .cornerRadius(30)
        .font(.headline)
            Spacer()
        }
        }.edgesIgnoringSafeArea(.all)
    }
    
    private func diceRoll() {
        let newRoll = Int.random(in: 1...6)
        diceValue = newRoll
        diceValues.values.append(newRoll)
        print(diceValue)
    }
}

