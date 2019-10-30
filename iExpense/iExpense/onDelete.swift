//
//  onDelete.swift
//  iExpense
//
//  Created by roblack on 10/29/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct onDelete: View {
    
    @State var numbers = [Int]()
    @State var currentNumber = 1

    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView {
        VStack {
            List {
                ForEach(numbers, id: \.self) {
                    Text("\($0)")
                }
            .onDelete(perform: removeRows)
            }

            Button("Add Number") {
                self.numbers.append(self.currentNumber)
                self.currentNumber += 1
            }
        }
            .navigationBarItems(leading: EditButton())
    }
    
    }
}

struct onDelete_Previews: PreviewProvider {
    static var previews: some View {
        onDelete()
    }
}
