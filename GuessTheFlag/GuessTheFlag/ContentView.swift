//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by roblack on 10/13/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    var image: String
    
    var body: some View {
//        content
        Image(image)
        .renderingMode(.original)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.white, lineWidth: 5))
        .shadow(color: .gray, radius: 25)
    }
}

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    
    @State private var animateButtons = false
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Spacer()
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.headline)
                        .autocapitalization(.allCharacters)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.answerTapped(number)
                        self.animateButtons.toggle()
                    }) {
//                        Image(self.countries[number])
                        FlagImage(image: self.countries[number])
                    }
                }
                Text("SCORE: \(score)")
                    .foregroundColor(.white)
                    .font(.headline)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                })
        }
    }
    
    func answerTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            scoreTitle = "CORRECT!"
            scoreMessage = "Your score is: \(score)"
            
        } else {
            score -= 1
            scoreTitle = "!WRONG!"
            scoreMessage = "That's the flag of \(countries[number])\nYour score is now: \(score)"
            
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
