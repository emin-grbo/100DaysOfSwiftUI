//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by roblack on 11/25/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct FilteredList: View {
    
    var fetchRequest: FetchRequest<Singer>
    var singers: FetchedResults<Singer> { fetchRequest.wrappedValue }
    
    init(sort: NSSortDescriptor, predicate: BeginsWith, filter: String) {
        
        var predicateValue : String {
            switch predicate {
            case .lastName:
                return "lastName"
            case .firstName:
                return "firstName"
            }
        }
        
        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: [sort], predicate: NSPredicate(format: "%K BEGINSWITH %@", predicateValue, filter))
    }
    
    var body: some View {
        List(singers, id: \.self) { singer in
            Text("\(singer.wrappedLastName) \(singer.wrappedFirstName)")
        }
    }
}
