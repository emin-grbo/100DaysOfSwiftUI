//
//  AddItemView.swift
//  iHabit
//
//  Created by roblack on 11/10/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct AddItemView: View {
    
    @State var itemTitle: String = ""
    
    var body: some View {
        VStack {
        TextField("Item Title", text: $itemTitle)
            Spacer(minLength: 32)
        TextField("Item Subtitle", text: $itemTitle)
            
        }
    .padding()
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
