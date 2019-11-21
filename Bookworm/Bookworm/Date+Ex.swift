//
//  Date+Ex.swift
//  Bookworm
//
//  Created by roblack on 11/21/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        return dateFormatter.string(from: self)
        
        
        
    }
}
