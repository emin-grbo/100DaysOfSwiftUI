//
//  ContentView.swift
//  Moonshot
//
//  Created by roblack on 11/1/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showNames = false
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .accessibility(hidden: true)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(self.showNames ? mission.formattedCrew : mission.formattedLaunchDate)
                    }
                }
            }
        .navigationBarTitle("Moonshot")
        .navigationBarItems(trailing:
            HStack {
                Toggle(isOn: $showNames){
                Text("Show Names")
                }
            .accessibility(label: Text("Show names of astronauts instead of dates."))
            }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
