//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by roblack on 10/20/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var computerChoice = Int.random(in: 0...2)
    @State private var computerInstruction = Bool.random()
    
    @State private var showScore = false
    @State private var endGame = false
    
    @State private var result: Bool = nil
    
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    @State private var round = 0
    
    var moves = ["✊", "✋", "✌️"]
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
        VStack {
            Spacer()
            VStack {
                Text("SCORE: \(score)")
                    .font(.headline)
                Spacer()
                Text("I WILL PICK")
                    .font(.title)
                    .fontWeight(.black)
                Text("\(moves[computerChoice])")
                    .font(.system(size: 100))
                Text("\(computerInstruction ? "BEAT ME!" : "Let me WIN?")")
                    .font(.callout)
                Spacer()
            }
                .alert(isPresented: $showScore) {
                    Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                        self.resetGame()
                        })
            }
            Spacer()
            HStack {
                ForEach(moves, id: \.self) { move in
                    Button(action: {
                        self.judge(move)
                    }) {
                        Text(move)
                            .font(.system(size: 80))
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .alert(isPresented: $endGame) {
                Alert(title: Text("GAME OVER"), message: Text("Your Final score is: \(score)"), dismissButton: .default(Text("RESTART")) {
                    self.resetGame()
                    self.round = 0
                    self.score = 0
                    })
            }
            Spacer()
        }
        }
    }
    
    func resetGame() {
        computerChoice = Int.random(in: 0...2)
        computerInstruction = Bool.random()
        result = nil
    }
    
    func judge(_ answer: String) {
        
        let computer = moves[computerChoice]

        if computerInstruction {
            switch computer {
            case "✊": if answer == "✋" { result = true } else { result = false }
            case "✋": if answer == "✌️" { result = true } else { result = false }
            case "✌️": if answer == "✊" { result = true } else { result = false }
            default: result = false
            }
        } else {
            switch computer {
            case "✊": if answer == "✌️" { result = true } else { result = false }
            case "✋": if answer == "✊" { result = true } else { result = false }
            case "✌️": if answer == "✋" { result = true } else { result = false }
            default: result = false
            }
        }
        
        if computer == answer { result = nil }
        
        if result != nil && result! {
            scoreTitle = "NICE"
            scoreMessage = "You Win!"
            score += 1
        } else if result != nil && !result! {
            scoreTitle = "BUMMER"
            scoreMessage = "You Lose!"
            score -= 1
        } else {
            scoreTitle = "RLY?"
            scoreMessage = "Do you even know how to play this game?"
        }
        if round == 3 {
            endGame = true
        } else {
            showScore = true
            round += 1
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


