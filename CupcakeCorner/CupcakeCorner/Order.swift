//
//  Order.swift
//  CupcakeCorner
//
//  Created by roblack on 11/12/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import Foundation

class Order: ObservableObject {

    @Published var orderInfo: OrderInfo
    
    enum CodingKeys: CodingKey {
        case orderInfo
    }
    
    init() {
        self.orderInfo = OrderInfo()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderInfo, forKey: .orderInfo)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orderInfo = try container.decode(OrderInfo.self, forKey: .orderInfo)
    }
    
    

}





struct OrderInfo: Codable {

    static let types : [String] = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if !specialRequestEnabled {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name  = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty
            || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty
            || city.isEmpty
            || zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        return cost
    }
    
            
}
