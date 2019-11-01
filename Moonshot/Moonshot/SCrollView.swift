//
//  SCrollView.swift
//  Moonshot
//
//  Created by roblack on 11/1/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct SCrollView: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 10) {
                ForEach(0..<100) {
                    Text("Item\($0)")
                        .font(.title)
                }
            }
        }
    }
}

struct SCrollView_Previews: PreviewProvider {
    static var previews: some View {
        SCrollView()
    }
}
