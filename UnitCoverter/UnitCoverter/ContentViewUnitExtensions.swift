//
//  ContentViewUnitExtensions.swift
//  UnitCoverter
//
//  Created by roblack on 10/12/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import Foundation

extension ContentView {
    
    enum UnitType: CustomStringConvertible {
        case length, temperature, time, volume
        case meters, kilometers, feet, yards, miles
        case Celsius, Kelvin, Fahrenheit
        case seconds, minutes, hours, miliseconds, microseconds
        case milliliters, liters, cups, pints, gallons
        
        var description: String {
            switch self {
            case .length:       return "length"
            case .temperature:  return "temperature"
            case .time:         return "time"
            case .volume:       return "volume"
            case .meters:       return "meters"
            case .kilometers:   return "kilometers"
            case .feet:         return "feet"
            case .yards:        return "yards"
            case .miles:        return "miles"
            case .Celsius:      return "Celsius"
            case .Kelvin:       return "Kelvin"
            case .Fahrenheit:   return "Fahrenheit"
            case .seconds:      return "seconds"
            case .minutes:      return "minutes"
            case .hours:        return "hours"
            case .miliseconds:  return "miliseconds"
            case .microseconds: return "microseconds"
            case .milliliters:  return "mililiters"
            case .liters:       return "liters"
            case .cups:         return "cups"
            case .pints:        return "pints"
            case .gallons:      return "gallons"
            }
        }
    }
    
    func selectedUnit(_ value: UnitType) -> Dimension {
        switch value {
        case .meters:           return UnitLength.meters
        case .kilometers:       return UnitLength.kilometers
        case .feet:             return UnitLength.feet
        case .yards:            return UnitLength.yards
        case .miles:            return UnitLength.miles
        case .Celsius:          return UnitTemperature.celsius
        case .Kelvin:           return UnitTemperature.kelvin
        case .Fahrenheit:       return UnitTemperature.fahrenheit
        case .seconds:          return UnitDuration.seconds
        case .minutes:          return UnitDuration.minutes
        case .hours:            return UnitDuration.hours
        case .miliseconds:      return UnitDuration.milliseconds
        case .microseconds:     return UnitDuration.microseconds
        case .milliliters:      return UnitVolume.milliliters
        case .liters:           return UnitVolume.liters
        case .cups:             return UnitVolume.cups
        case .pints:            return UnitVolume.pints
        case .gallons:          return UnitVolume.gallons
        default: return UnitLength.meters
        }
    }
    
    
    
    
    
    
    
    
    
}
