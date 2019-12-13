//
//  ContentView.swift
//  NameFaceMILSETONE
//
//  Created by roblack on 12/10/19.
//  Copyright © 2019 roblack. All rights reserved.
//
import CoreData
import SwiftUI
import CoreLocation

struct ContentView: View {
    
    let locationFetcher = LocationFetcher()
    @State private var currentLocation: CLLocationCoordinate2D?
    
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
            }.onAppear(perform: getLocation)
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
                AddPersonView(currentUserLocation: self.currentLocation).environment(\.managedObjectContext, self.moc)
            }
        }
    }
    
    func getLocation() {
        self.locationFetcher.start()
        self.currentLocation = self.locationFetcher.lastKnownLocation
        print(currentLocation)
    }
    
    func loadUserImage(uuid: UUID) -> Image {
        if let uiImage = FileManager().loadPhoto(withName: uuid.uuidString){
            return Image(uiImage: uiImage)
        } else {
            return Image(systemName: "person.crop.circle.fill")
        }
    }
}



class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}

