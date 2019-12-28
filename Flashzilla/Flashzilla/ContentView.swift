//
//  ContentView.swift
//  Flashzilla
//
//  Created by roblack on 12/18/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var feedback = UINotificationFeedbackGenerator()
    @State private var isReadoable = true
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    @State private var showingEditScreen = false
    
    @State private var cards = [Card]()
    
    @State private var isActive = true
    
    @State private var timeRemaining = 5
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        HStack {
                            Text("Redoable?")
                                .font(.callout)
                        Toggle(isOn: $isReadoable) {
                            Text("Persistant False")
                                .font(.callout)
                        }.labelsHidden()
                        }
                            .padding()
                        .background(Capsule()
                        .fill(Color.black)
                        .opacity(0.75))
                        
                        
                        Spacer()
                        Text("Time: \(timeRemaining)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(Color.black)
                                .opacity(0.75)
                        )
                        Spacer()

                        Button(action: {
                            self.showingEditScreen = true
                        }) {
                            Image(systemName: "plus.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                    }

                    Spacer()
                }
                .foregroundColor(.white)
                .font(.largeTitle)
                .padding()
                ZStack {
                ZStack {
                    if differentiateWithoutColor || accessibilityEnabled {
                        VStack {
                            Spacer()
                            HStack {
                                Button(action: {
                                    withAnimation {
                                        self.removeCard(at: self.cards.count - 1)
                                    }
                                }) {
                                    Image(systemName: "xmark.circle")
                                        .padding()
                                        .background(Color.black.opacity(0.7))
                                        .clipShape(Circle())
                                }
                                .accessibility(label: Text("Wrong"))
                                .accessibility(hint: Text("Mark your answer as being incorrect."))
                                Spacer()

                                Button(action: {
                                    withAnimation {
                                        self.removeCard(at: self.cards.count - 1)
                                    }
                                }) {
                                    Image(systemName: "checkmark.circle")
                                        .padding()
                                        .background(Color.black.opacity(0.7))
                                        .clipShape(Circle())
                                }
                                .accessibility(label: Text("Correct"))
                                .accessibility(hint: Text("Mark your answer as being correct."))
                            }
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .padding()
                        }
                    }
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: self.cards[index]) { (result) in
                           withAnimation {
                               self.removeCard(at: index, isWrong: result)
                           }
                        }
                        .stacked(at: index, in: self.cards.count)
                        .allowsHitTesting(index == self.cards.count - 1)
                        .accessibility(hidden: index < self.cards.count - 1)
                    }
                    
                }
                .allowsHitTesting(timeRemaining > 0)
                if timeRemaining == 0 {
                    ZStack {
                    Rectangle()
                        .background(Color.red)
                        .opacity(0.8)
                        VStack {
                            Spacer()
                            Text("Sry, time's out.\nYou had \(cards.count) cards left.")
                                .font(.headline)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                            Spacer(minLength: 20)
                            Button("Start Again", action: resetCards)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .clipShape(Capsule())
                            Spacer()
                        }
                    }.edgesIgnoringSafeArea(.all)
                    .onAppear(perform: endGame)
                } else if cards.isEmpty && !isActive {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
                }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards()
        }
        .onAppear(perform: resetCards)
        .onReceive(timer) { time in
            guard self.isActive else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if self.cards.isEmpty == false {
                self.isActive = true
            }
        }
    }
    
    func endGame() {
        self.feedback.notificationOccurred(.error)
        self.feedback.notificationOccurred(.warning)
    }
    
    func removeCard(at index: Int, isWrong: Bool? = false) {
        guard index >= 0 else { return }
        let currentCard = cards[index]
        
        if isReadoable && isWrong! {
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                self.cards.insert(currentCard, at: 0)
            }
        }
        cards.remove(at: index)

        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = 10
        isActive = true
        loadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }

}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}


