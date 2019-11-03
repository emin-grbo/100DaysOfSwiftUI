//
//  TestViewq.swift
//  MultiplicationTable
//
//  Created by roblack on 11/2/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct TestView: View {
    
    @State private var text = ""

    var body: some View {
        MyTextField(text: $text, placeholder: "")
            .frame(width: 200, height: 50)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}


struct MyTextField: View {
   @Binding var text: String
    var placeholder: String
    @State var showClearButton = true
   var body: some View {
       TextField(placeholder, text: $text, onEditingChanged: { editing in
           self.showClearButton = editing
       }, onCommit: {
           self.showClearButton = false
       }).modifier(ClearButton(text: $text, visible: $showClearButton))
   }
}

struct ClearButton: ViewModifier {
   @Binding var text: String
   @Binding var visible: Bool
   public func body(content: Content) -> some View {
       HStack {
           Button(action: {
               self.text = ""
           }) {
               Image(systemName: "multiply.circle.fill")
                   .foregroundColor(.secondary)
           }
           .opacity(visible ? 1 : 0)
       }
   }
}
