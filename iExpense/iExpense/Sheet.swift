//
//  Sheet.swift
//  iExpense
//
//  Created by roblack on 10/29/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    var name: String
    
    var body: some View {
        Group {
            Spacer()
            Text("Hello \(name)")
            Spacer(minLength: 20)
            Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }
            Spacer()
        }
    }
}

struct Sheet: View {
    
    @State private var showingSheet = false
    
    var body: some View {
                Button("Show Sheet") {
            self.showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: "roblack")
        }
    }
}

struct Sheet_Previews: PreviewProvider {
    static var previews: some View {
        Sheet()
    }
}
