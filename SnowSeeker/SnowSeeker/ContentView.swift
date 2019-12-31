//
//  ContentView.swift
//  SnowSeeker
//
//  Created by roblack on 12/29/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

enum SortOrder {
    case def, alphabetical, country
}

enum FilterCountries {
    case us, au, fr, ca, it, all
}

struct ContentView: View {
    
    @State private var showingSortOptions = false
    @State private var filterSelected = false
    
    @State private var sortOrder : SortOrder = .def
    @State private var filterCountries : FilterCountries = .all

    var resorts: [Resort] {
        let all = Bundle.main.decode("resorts.json") as [Resort]
        var filtered = all
        
        switch filterCountries {
        case .us:
            filtered = all.filter { $0.country == "United States"}
        case .au:
            filtered = all.filter { $0.country == "Austria"}
        case .fr:
            filtered = all.filter { $0.country == "France"}
        case .ca:
            filtered = all.filter { $0.country == "Canada"}
        case .it:
            filtered = all.filter { $0.country == "Italy"}
        case .all:
            filtered = all
        }
        
        
        
        
        switch sortOrder {
        case .def: return filtered
        case .alphabetical: return filtered.sorted { $0.name > $1.name }
        case .country: return filtered.sorted { $0.country > $1.country }
        }

    }

    @ObservedObject var favorites = Favorites()
    
    var body: some View {
        NavigationView {
            List(resorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )

                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                        .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(Color.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            
            .navigationBarItems(leading: Button("Sort"){
                self.showingSortOptions.toggle()
                }, trailing: Button("Filter"){
                    self.filterSelected.toggle()
            })
            
            .actionSheet(isPresented: $filterSelected) { () -> ActionSheet in
                ActionSheet(title: Text("Filter Contacts"), message: Text("Select which country to filter"), buttons: [
                    .default(Text("United States")) { self.filterCountries = .us },
                    .default(Text("Austria")) { self.filterCountries = .au },
                    .default(Text("France")) { self.filterCountries = .fr },
                    .default(Text("Canada")) { self.filterCountries = .ca },
                    .default(Text("Italy")) { self.filterCountries = .it },
                    .default(Text("ALL")) { self.filterCountries = .all },
                    .cancel()
                ])
            }
//            .phoneOnlyStackNavigationView()
            WelcomeView()
        }
        .environmentObject(favorites)
        .actionSheet(isPresented: $showingSortOptions) { () -> ActionSheet in
            ActionSheet(title: Text("Sort Contacts"), message: Text("Select sorting style"), buttons: [
                .default(Text("Sort by default")) { self.sortOrder = .def },
                .default(Text("Sort alphabetically")) { self.sortOrder = .alphabetical },
                .default(Text("Sort by Country")) { self.sortOrder = .country },
                .cancel()
            ])
        }
    }
}




extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}
