//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by roblack on 12/29/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ResortDetailsView: View {
    
    let resort: Resort
    var size: String {
        switch resort.size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    var price: String {
        String(repeating: "$", count: resort.price)
    }
    
    var body: some View {
        VStack {
            Text("Size: \(size)")
            Text("Price: \(price)")
        }
    }
}

