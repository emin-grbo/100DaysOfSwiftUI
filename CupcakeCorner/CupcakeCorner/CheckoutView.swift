//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by roblack on 11/12/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var alertTitle = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                        .accessibility(hidden: true)

                    Text("Your total is $\(self.order.orderInfo.cost, specifier: "%.2f")")
                        .font(.title)

                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text(alertTitle), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order.orderInfo) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                self.alertTitle = "\(error?.localizedDescription ?? "Error")"
                self.confirmationMessage = "Your order for failed to send. No cupcakes for you!"
                self.showingConfirmation = true
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(OrderInfo.self, from: data) {
                self.alertTitle = "Thank you!"
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(OrderInfo.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                self.alertTitle = "Sorry"
                self.confirmationMessage = "Your order for failed to send. No cupcakes for you!"
                self.showingConfirmation = true
            }
        }.resume()
    }

}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
