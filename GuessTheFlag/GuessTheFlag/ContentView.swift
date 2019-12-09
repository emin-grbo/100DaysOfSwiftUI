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
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    
    @State private var opacityAmount = 1.0
    @State private var rotationAmount = 0.0
    @State private var wrongRotationAmount = [0.0, 0.0, 0.0]
    
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
                
                ForEach(0 ..< 3, id: \.self) { number in
                    
                    Button(action: {
                        self.opacityAmount = 0.8
                        self.answerTapped(number)
                    }) {
                        FlagImage(image: self.countries[number])
                            .accessibility(label: Text(self.labels[self.countries[number], default: "Unknown Flag"]))
                    }
                    .opacity(number == self.correctAnswer ? 1 : self.opacityAmount)
                    .rotation3DEffect(.degrees(number == self.correctAnswer ? self.rotationAmount : 0),
                                      axis: (x: 0, y: 1, z: 0))
                    .rotation3DEffect(.degrees(self.wrongRotationAmount[number]),
                                      axis: (x: 0, y: 1, z: 0))
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
            rotationAmount = 0.0
            
            withAnimation(.interpolatingSpring(stiffness: 20, damping: 5)) {
                self.rotationAmount = 360
            }
            
        } else {
            score -= 1
            scoreTitle = "!WRONG!"
            scoreMessage = "That's the flag of \(countries[number])\nYour score is now: \(score)"
            
            withAnimation(Animation.interpolatingSpring(mass: 1, stiffness: 120, damping: 40, initialVelocity: 200)) {
                self.wrongRotationAmount[number] = 1
            }

        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        withAnimation(.easeInOut) {
            self.opacityAmount = 1.0
        }
        self.rotationAmount = 0.0
        wrongRotationAmount = Array(repeating: 0.0, count: 3)
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
