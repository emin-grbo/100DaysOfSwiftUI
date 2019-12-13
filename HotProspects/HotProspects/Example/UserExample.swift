//
//  User.swift
//  HotProspects
//
//  Created by roblack on 12/12/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import Foundation
import SwiftUI

class UserExample: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: UserExample

    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: UserExample

    var body: some View {
        Text(user.name)
    }
}
