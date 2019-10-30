//
//  TableValue.swift
//  MultiplicationTable
//
//  Created by roblack on 10/30/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import Foundation

class TableValue: ObservableObject {
    
    init() {
        self.value = UserDefaults.standard.integer(forKey: "tableValue")
        
    }
    
    @Published var value: Int {
        didSet {
            UserDefaults.standard.set(self.value, forKey: "tableValue")
            
        }
    }
}


