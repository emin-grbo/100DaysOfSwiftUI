//
//  EnviromentObjectExample.swift
//  HotProspects
//
//  Created by roblack on 12/13/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct EnviromentObjectExample: View {
    let user = UserExample()

    var body: some View {
        VStack {
            EditView()
            DisplayView()
        }
    .environmentObject(user)
    }
}
