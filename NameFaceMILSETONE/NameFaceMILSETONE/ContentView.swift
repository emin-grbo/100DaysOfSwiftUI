//
//  ContentView.swift
//  NameFaceMILSETONE
//
//  Created by roblack on 12/10/19.
//  Copyright © 2019 roblack. All rights reserved.
//
import CoreData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Person.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Person.name, ascending: true)]) var people: FetchedResults<Person>
    
    @State private var showAddScreen = false
    
    var body: some View {
        NavigationView {
        List {
            ForEach(people, id: \.self) { person in
                NavigationLink(destination: AddPersonView(person: person).environment(\.managedObjectContext, self.moc)) {
                HStack {
                    Group {
                    if person.imgID != nil {
                        self.loadUserImage(uuid: person.imgID!)
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                    }
                    }
                    .frame(width: 32, height: 32, alignment: .center)
                    .scaledToFill()
                        
                    Text("\(person.name ?? "John Doe")")
                }
            }
            }
        }
        .navigationBarTitle(Text("FriendsFace"))
        .navigationBarItems(trailing: Button(action: {
            self.showAddScreen.toggle()
        }) {
            Text("Add a friend")
            Image(systemName: "plus")
            }
            .accentColor(.white)
            )
            .sheet(isPresented: $showAddScreen) {
                AddPersonView().environment(\.managedObjectContext, self.moc)
            }
        }
    }
    
    func loadUserImage(uuid: UUID) -> Image {
        if let uiImage = FileManager().loadPhoto(withName: uuid.uuidString){
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person.crop.circle.fill")
        }
    }
}
