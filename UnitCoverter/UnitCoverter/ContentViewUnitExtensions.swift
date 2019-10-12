//
//  ContentViewUnitExtensions.swift
//  UnitCoverter
//
//  Created by roblack on 10/12/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import Foundation

extension ContentView {
    
    func selectedUnit(_ value: Int) -> Dimension {
        switch value {
        case 0: return UnitLength.meters
        case 1: return UnitLength.kilometers
        case 2: return UnitLength.feet
        case 3: return UnitLength.yards
        case 4: return UnitLength.miles
        default: return  UnitLength.meters
        }
    }
    
    
    
    
    
    
    
    
    
}
