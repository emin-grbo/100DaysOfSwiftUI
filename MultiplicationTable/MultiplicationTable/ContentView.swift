//
//  ContentView.swift
//  MultiplicationTable
//
//  Created by roblack on 10/28/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI


//class TableValue: ObservableObject {
//    @Published var tableValue = 0
//    UserDefaults.standard.integer(forKey: "Table")
//}

struct ContentView: View {
    
    @ObservedObject var table = TableValue()
    @State private var number = Int.random(in: 1...10)
    
    @State private var randomCol = Int.random(in: 0...1)
    @State private var randomRow = Int.random(in: 0...1)
    
    @State private var currentQuestion = 0
    
    @State private var showingAlert = false
    @State private var isShowingOptions = false
    @State private var isShowingHighscore = false
    
    @State private var correctAnswers = 0.0
    @State private var percentage = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    
                    Text("Answer me this:")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Text("\(table.value) x \(number)")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    
                    Spacer()
                    
                    GridStack(rows: 2, columns: 2) { (row, col) in
                        Button(action: {
                            if row == self.randomCol && col == self.randomRow {
                                print("CORRECT")
                                self.table.questionsArray[self.currentQuestion] = .correct
                            } else {
                                print("WRONG")
                                self.table.questionsArray[self.currentQuestion] = .wrong
                            }
                            if self.currentQuestion == self.table.questionsArray.count - 1 {
                                self.correctAnswers =
                                    (Double((self.table.questionsArray.filter{ $0 == .correct }).count)
                                    / Double(self.table.questionsArray.count)) * 100
//                                self.percentage = correctAnswers.rounded()
//                                self.percentage = String(format: "%.2f", correctAnswers)
                                
                                self.showingAlert = true
                            }
                            self.currentQuestion += 1
                            self.nextQuestion()
                        }) {
                            if row == self.randomCol && col == self.randomRow {
                                Text("\(self.table.value * self.number)")
                            } else {
                                Text("\(Int.random(in: 1...100))")
                            }
                        }
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.blue)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    }
                    .frame(maxWidth: 300)
                    Spacer(minLength: 10)
                    
                    HStack {
                        ForEach(self.table.questionsArray, id: \.self) { q in
                            Circle()
                                .colorize(question: q)
                                .frame(width: 10, height: 10)
                        }
                    }
                    Spacer()
                }
            }
            .navigationBarItems(leading: Text("iMultiply")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white),
                                trailing:
                HStack {
                    Button(action: {
                        self.isShowingHighscore = true
                    }) {
                        Image(systemName: "chart.bar.fill").foregroundColor(.white)
                    }
                    Spacer(minLength: 20)
                    Button(action: {
                        self.isShowingOptions = true
                    }) {
                        Image(systemName: "eject.fill").foregroundColor(.white)
                    }
                }
            )
            
            
        }
        .alert(isPresented: $showingAlert) {
            return Alert(title: Text("Well done!"),
                  message: Text("You answered -> \(correctAnswers, specifier: "%.f")%\nof questions correctly."),
 
                  dismissButton: .default(Text("Done")) {
                    self.resetGame()
                })
        }
        .sheet(isPresented: $isShowingOptions) {
            OptionsSheet(table: self.table)
        }
        .onAppear {
            self.isShowingOptions = true
        }
        .sheet(isPresented: $isShowingHighscore) {
            HighscoreView()
        }
    }


    
}

extension ContentView {
    func nextQuestion() {
        number = Int.random(in: 1...10)
        randomCol = Int.random(in: 0...1)
        randomRow = Int.random(in: 0...1)
    }
    
    func resetGame() {
        currentQuestion = 0
        isShowingOptions = true
        nextQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

