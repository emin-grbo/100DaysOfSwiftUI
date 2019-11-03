//
//  GridStack.swift
//  MultiplicationTable
//
//  Created by roblack on 10/28/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct GridStack<Content: View>: View {
    
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    
    var body: some View {
        VStack {
            ForEach(0 ..< rows) { row in
                HStack{
                    ForEach(0 ..< self.columns) { column in
                        self.content(row, column)
                        .padding(10)
                    }
                }
            }
        }
    }
}

struct GridStack_Previews: PreviewProvider {
    static var previews: some View {
        GridStack(rows: 2, columns: 2) { row, col in
            Text("\(row)")
        }
    }
}
