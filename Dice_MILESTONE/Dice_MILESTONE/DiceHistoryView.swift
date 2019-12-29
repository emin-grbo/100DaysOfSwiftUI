//
//  DiceHistoryView.swift
//  Dice_MILESTONE
//
//  Created by roblack on 12/29/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct DiceHistoryView: View {
    
    @EnvironmentObject var diceValues: DiceValues
    
    var body: some View {
        List {
            ForEach(diceValues.values, id: \.self) { dice in
                HStack {
                    Text("You rolled \(dice) or put fancily")
                    Image("\(dice)")
                    .resizable()
                    .scaledToFit()
                        .frame(width: 24, height: 24)
                }
            }
        }
    }
}

struct DiceHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        DiceHistoryView()
    }
}
