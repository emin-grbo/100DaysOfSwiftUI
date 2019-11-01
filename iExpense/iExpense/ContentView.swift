//
//  ContentView.swift
//  iExpense
//
//  Created by roblack on 10/29/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    func itemValue(amount: Int) -> Text {
        switch (amount < 10, amount > 100) {
        case (true, false): return Text("$\(amount)").foregroundColor(.green)
        case (false, true): return Text("$\(amount)").foregroundColor(.red)
        case (false, false): return Text("$\(amount)").foregroundColor(.yellow)
        default: return Text("")
        }
    }
    
    var body: some View {

        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        self.itemValue(amount: item.amount)
                    }
                }
                .onDelete(perform: removeItems)
            }
        .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(),trailing:
            Button(action: {
                self.showingAddExpense = true
            }) {
                Image(systemName: "eject.fill")
            }
            )
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }

}
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
