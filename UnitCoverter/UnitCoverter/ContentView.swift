//
//  ContentView.swift
//  UnitCoverter
//
//  Created by roblack on 10/12/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var units: [[UnitType]] = [
        [.meters, .kilometers, .feet, .yards, .miles],
        [.Celsius, .Fahrenheit, .Kelvin],
        [.seconds, .minutes, .hours, .miliseconds, .microseconds],
        [.milliliters, .liters, .cups, .pints, .gallons]
    ]
    
    @State var inputUnitTypes: [UnitType] = [.length, .temperature, .time, .volume]
    
    @State var input = ""

    @State var unit = 0
    @State var inputUnit = 0
    @State var outputUnit = 0
    
    var selected: [UnitType] {
        return units[unit]
    }

    var output: String {
        return converter()
    }
    
    func converter() -> String {
        guard let input: Int = Int(input) else { return "0" }
        
        let inUnit = selectedUnit(units[unit][inputUnit])
        let outUnit = selectedUnit(units[unit][outputUnit])
        
        let fromValue = Measurement(value: Double(input), unit: inUnit)
        let toValue = fromValue.converted(to: outUnit)
        return "\(toValue)"
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input Unit", text: $input)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                    
                    // MARK: - Unit Picker
                    Picker("Length", selection: $unit) {
                        ForEach(0 ..< inputUnitTypes.count) {
                            Text("\(self.inputUnitTypes[$0].description)")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                HStack {
                    // MARK: - Input Unit Picker
                    Section(header: Text("From")) {
                        Picker("Length", selection: $inputUnit) {
                            ForEach(0 ..< selected.count) {
                                Text("\(self.selected[$0].description)")
                            }
                        }
                        .id(unit)
                        .pickerStyle(WheelPickerStyle())
                        .frame(minWidth: 0, maxWidth: .infinity/2, alignment: .center)
                    }
                    
                    Section(header: Text("To")) {
                        // MARK: - Output Unit Picker
                        Picker("Length", selection: $outputUnit) {
                            ForEach(0 ..< selected.count) {
                                Text("\(self.selected[$0].description)")
                            }
                        }
                        .id(unit)
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
