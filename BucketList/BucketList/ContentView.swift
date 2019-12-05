//
//  ContentView.swift
//  BucketList
//
//  Created by roblack on 11/30/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI
import LocalAuthentication
import MapKit

struct ContentView: View {
    
    @State private var isUnlocked = false
    
    @State private var isShowingError = false
    @State private var errorMessage = ""
    
    var body: some View {
        
        Group {
            if isUnlocked {
                UnlockedMapView()
            } else {
                Button("Unlock Places") {
                    self.authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .alert(isPresented: $isShowingError) {
                    Alert(title: Text("Error has occured"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.isShowingError.toggle()
                        self.errorMessage = authenticationError?.localizedDescription ?? "Unknown error"
                    }
                }
            }
        } else {
            isShowingError.toggle()
            errorMessage = "No Biometrics"
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
