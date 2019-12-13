//
//  UserMapView.swift
//  NameFaceMILSETONE
//
//  Created by roblack on 12/12/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct UserMapView: View {
    
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [MKPointAnnotation]()
    @State var currentUserLocation: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 51.5, longitude: 0.13)
    
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    
    @State private var showingEditScreen = false
    
    var body: some View {
        return ZStack {
            MapView(centerCoordinate: $currentUserLocation, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newLocation = MKPointAnnotation()
                        newLocation.coordinate = self.centerCoordinate
                        newLocation.title = "Example location"
                        self.locations.append(newLocation)
                        self.selectedPlace = newLocation
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
                    }
                    .padding()
                }
            }
        }
    }

}
