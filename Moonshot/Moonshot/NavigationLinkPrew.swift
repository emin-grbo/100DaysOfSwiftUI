//
//  NavigationLink.swift
//  Moonshot
//
//  Created by roblack on 11/1/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct NavigationLinkPrew: View {
    var body: some View {
        NavigationView {
            List(0..<100) { row in
                NavigationLink(destination: Text("Detail \(row)")) {
                    Text("Hello, row: \(row)")
                }
            }
            .navigationBarTitle("SwiftUI")
        }
    }
}

struct NavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLinkPrew()
    }
}
