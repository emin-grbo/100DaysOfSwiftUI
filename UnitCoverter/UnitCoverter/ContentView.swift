//
//  ContentView.swift
//  UnitCoverter
//
//  Created by roblack on 10/12/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var lengthInputs = ["meters", "kilometers", "feet", "yard", "miles"]
    @State var tempInputs = ["Celsius", "Fahrenheit", "Kelvin"]
    @State var timeInputs = ["seconds", "minutes", "hours", "days"]
    @State var volumeInputs = ["milliliters", "liters", "cups", "pints", "gallons"]
    
    @State var inputUnitTypes = ["length", "temperature", "time", "volume"]
    
    @State var selectedInput = ""
//    @State var selectedOutput = ""
    
    @State var unit = 2
    @State var inputUnit = 2
    @State var outputUnit = 2
    @State var fromText = "0"
    
    var output: String {
        return converter()
    }
    
    func converter() -> String {
        guard let input: Int = Int(selectedInput) else { return "0" }
        
        var inUnit = selectedUnit(inputUnit)
        
        var outUnit = selectedUnit(outputUnit)
        
        let fromValue = Measurement(value: Double(input), unit: inUnit)
        let toValue = fromValue.converted(to: outUnit)
        
        return "\(toValue)"
    }
    
//    var selectedOutput: String {
//        return "\(lengthInputs[outputUnit])"
//    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input Unit", text: $selectedInput)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                    
                    // MARK: - Unit Picker
                    Picker("Length", selection: $unit) {
                        ForEach(0 ..< inputUnitTypes.count) {
                            Text("\(self.inputUnitTypes[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                HStack {
                    // MARK: - Input Unit Picker
                    Section(header: Text("From")) {
                        Picker("Length", selection: $inputUnit) {
                            ForEach(0 ..< lengthInputs.count) {
                                Text("\(self.lengthInputs[$0])")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(minWidth: 0, maxWidth: .infinity/2, alignment: .center)
                    }
                    
                    Section(header: Text("To")) {
                        // MARK: - Output Unit Picker
                        Picker("Length", selection: $outputUnit) {
                            ForEach(0 ..< lengthInputs.count) {
                                Text("\(self.lengthInputs[$0])")
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(minWidth: 0, maxWidth: .infinity/2, alignment: .center)
                    }
                        
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                }
                
                // MARK: - Output
                Section {
                    Text("\(self.output)")
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationBarTitle("UnitConverter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
