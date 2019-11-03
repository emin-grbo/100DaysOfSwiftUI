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
    
    @State private var selection = 0
    var questionOptionsArray = [5,10,15]
    
    var body: some View {

        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer(minLength: 50)
                
                VStack {
                        Text("Number of Q's?")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                    Picker(selection: $selection, label: Text("Number")) {
                        ForEach(0 ..< questionOptionsArray.count, id: \.self) {
                            Text("\(self.questionOptionsArray[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                    .padding()
                
                Spacer(minLength: 25)
                
                Text("Choose Thy Number!")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Spacer()
                GridStack(rows: 3, columns: 3) { row, col in
                    TableButton(text: "\(row * 3 + col + 1)") {
                        let number: Int = row * 3 + col + 1
                        self.table.value = number

                        self.table.numberOfQuestions = self.questionOptionsArray[self.selection]
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }

                Spacer(minLength: 50)
            }
        }
    }
}

struct OptionsSheet_Previews: PreviewProvider {
    static var previews: some View {
        OptionsSheet(table: TableValue())
    }
}
