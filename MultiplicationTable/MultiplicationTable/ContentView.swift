//
//  ContentView.swift
//  MultiplicationTable
//
//  Created by roblack on 10/28/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var num: Int = 1
    
//    var num : Int = 1
    
    func increment() -> Int {
        num += 1
        return num
    }
    
    var body: some View {

        
        
        ZStack {
            Color.orange.edgesIgnoringSafeArea(.all)
            
            GridStack(rows: 3, columns: 3) { row, col in
                TableButton(text: "\(row * 3 + col + 1)") {
                    //
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
