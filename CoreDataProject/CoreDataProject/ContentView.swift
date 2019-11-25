//
//  ContentView.swift
//  CoreDataProject
//
//  Created by roblack on 11/21/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

enum BeginsWith {
    case lastName
    case firstName
}

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State var filterValue = "A"
    
    var body: some View {
        VStack {
            FilteredList(sort: NSSortDescriptor(keyPath: \Singer.lastName, ascending: true), predicate: .lastName, filter: filterValue)
            HStack {
            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                let andy = Singer(context: self.moc)
                andy.firstName = "Ivan Konstantinovich"
                andy.lastName = "Aivazovsky"
                
                let aach = Singer(context: self.moc)
                aach.firstName = "Alessandro"
                aach.lastName = "Allori"
                
                let abel = Singer(context: self.moc)
                abel.firstName = "Paul"
                abel.lastName = "Sandby"
                
                let saar = Singer(context: self.moc)
                saar.firstName = "Alfred"
                saar.lastName = "Sisley"

                try? self.moc.save()
            }

            Button("Show A") {
                self.filterValue = "A"
            }

            Button("Show S") {
                self.filterValue = "S"
            }
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
