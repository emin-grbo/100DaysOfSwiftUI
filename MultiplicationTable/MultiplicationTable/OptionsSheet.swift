//
//  OptionsSheet.swift
//  MultiplicationTable
//
//  Created by roblack on 10/29/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct OptionsSheet: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var table : TableValue
    
    var body: some View {

        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Text("Choose Thy Number!")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer()
                GridStack(rows: 3, columns: 3) { row, col in
                    TableButton(text: "\(row * 3 + col + 1)") {
                        let number: Int = row * 3 + col + 1
                        self.table.value = number
                        UserDefaults.standard.set(number, forKey: "tableValue")
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                Spacer()
            }
        }
    }
}

struct OptionsSheet_Previews: PreviewProvider {
    static var previews: some View {
        OptionsSheet(table: TableValue())
    }
}
