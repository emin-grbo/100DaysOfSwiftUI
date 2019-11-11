//
//  FormValidationExample.swift
//  CupcakeCorner
//
//  Created by roblack on 11/12/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct FormValidationExample: View {
    
    @State var username = ""
    @State var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }
        .disabled(disableForm)
        }
    }
}

struct FormValidationExample_Previews: PreviewProvider {
    static var previews: some View {
        FormValidationExample()
    }
}
