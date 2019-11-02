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
    @State private var isShowingOptions = false
    @State private var number = Int.random(in: 1...10)
    
    @State private var randomCol = Int.random(in: 0...1)
    @State private var randomRow = Int.random(in: 0...1)
    
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
                            } else {
                                print("WRONG")
                            }
                            
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
                        ForEach(0 ..< self.table.numOfQuestions, id: \.self) {
                            Text("test\($0)")
                        }
                    }
                }
            }
            .navigationBarItems(leading: Text("iMultiply")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundColor(.white),
                                trailing: Button(action: {
                self.isShowingOptions = true
            }) {
                Image(systemName: "eject.fill").foregroundColor(.white)
            })
        }
        .sheet(isPresented: $isShowingOptions) {
            OptionsSheet(table: self.table)
        }
        .onAppear {
            self.isShowingOptions = true
        }
    }


    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

