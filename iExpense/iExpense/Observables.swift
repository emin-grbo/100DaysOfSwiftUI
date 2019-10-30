//
//  Observables.swift
//  iExpense
//
//  Created by roblack on 10/29/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct Observables: View {
    @ObservedObject var user = User()

    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")

            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
    }
}

struct Observables_Previews: PreviewProvider {
    static var previews: some View {
        Observables()
    }
}

