//
//  ContentView.swift
//  BetterRest
//
//  Created by roblack on 10/20/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertShowing = false
    
    var bedTime: String {
        calculateBedtime()
    }
    
    var body: some View {
        NavigationView {
            VStack {
            Form {
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please Enter the Time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("How much would you like to sleep")) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                .accessibility(value: Text("\(sleepAmount) hours of sleep"))
                }
                
                Section(header: Text("Daily coffee intake")) {
                    Picker("", selection: $coffeeAmount) {
                        ForEach(1 ... 10, id: \.self) {
                            $0 == 1 ? Text("\($0) cup") : Text("\($0) cups")
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(WheelPickerStyle())
                    .frame(maxWidth: .infinity, maxHeight: 150)
                }
                .alert(isPresented: $alertShowing) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .cancel())
                }
                
            }
                VStack {
                    Text("Optimal bedtime")
                    Text("\(bedTime)")
                    .font(.largeTitle)
                    .fontWeight(.black)
                }
            }
        .navigationBarTitle("BetterRest")
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    func calculateBedtime() -> String {
        let model = SleepCalculator()
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try
            model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
        } catch {
            alertShowing = true
            alertTitle = "Error"
            alertMessage = "Sry, there was an error calculating your bedtime."
            return ""
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
           ContentView()
              .environment(\.colorScheme, .dark)
        }
    }
}
