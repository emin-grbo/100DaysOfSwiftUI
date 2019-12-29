//
//  ContentView.swift
//  WordScramble
//
//  Created by roblack on 10/22/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = ["trounced", "trouncer", "trounces", "troupers", "trouping", "trousers", "troweled", "truanted", "truckers", "trucking", "truckled", "truckles", "trudging", "truelove", "truffles", "trumpery", "trumpets", "trumping", "truncate", "trundled", "trundler", "trundles", "trunking", "trussing"]
    @State private var newWord = ""
    @State private var rootWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showwingError = false
    
    @State private var score = 0
    
    var body: some View {
        NavigationView() {
            VStack {
                TextField("Enter your word here", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                GeometryReader { fullView in
                    ScrollView(.vertical) {
                        ForEach(0..<self.usedWords.count - 1) { index in
                            GeometryReader { geo in
                                HStack {
                                Image(systemName: "\(self.usedWords[index].count).circle")
                                    .foregroundColor(Color(red: Double(geo.frame(in: .global).minY / fullView.size.height),
                                    green: 0.5,
                                    blue: 0.8))
                                Text("\(self.usedWords[index])")
                                    .font(.title)
                                    .foregroundColor(Color(red: Double(geo.frame(in: .global).minY / fullView.size.height),
                                    green: 0.2,
                                    blue: 0.9))
                                }
                                .frame(width: fullView.size.width, alignment: Alignment.leading)
                                .offset(x: (geo.frame(in: .global).minY - (fullView.size.height) > 8 ? geo.frame(in: .global).minY - (fullView.size.height) : 8),
                                        y: 0)
                                
                            }
                            .frame(height: 40)
                        }
                    }
                }
                Text("Score: \(score)")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding()
            }
            .navigationBarItems(trailing: Button("RESET", action: startGame).foregroundColor(.black))
        .navigationBarTitle(rootWord)
        .onAppear(perform: startGame)
            .alert(isPresented: $showwingError) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return}
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not reckognized", message: "You can't just make them up you know!")
            return
        }
        
        guard isRealWord(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word")
            return
        }
        
        usedWords.insert(answer, at: 0)
        
        score = 0
        
        for word in usedWords {
            score += 10
            score += word.count * 2
        }
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                print(allWords)
                return
            }
        }
        fatalError("Could not load start.txt from bundle")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
        if tempWord == word || word.count < 3 { return false }
        
        for letter in tempWord {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
            return false
            }
        }
        return true
    }
    
    func isRealWord(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showwingError = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
