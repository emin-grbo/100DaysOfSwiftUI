//
//  AstronautView.swift
//  Moonshot
//
//  Created by roblack on 11/3/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    let missions: [Mission]

    var body: some View {
       GeometryReader { geometry in
        ScrollView(.vertical) {
            VStack {
                Image(self.astronaut.id)
                .resizable()
                .scaledToFit()
                    .frame(width: geometry.size.width)
                
                HStack {
                    Text("Flew on")
                        .font(.callout)
                ForEach(self.missions) { mission in
                    HStack {
                    Text("| \(mission.displayName)")
                    }
                    .accessibilityElement(children: .combine)
                }
                }
                
                Text(self.astronaut.description)
                .padding()
                .layoutPriority(1)
            }
        }
        }
       .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut, missions: [Mission]) {
        self.astronaut = astronaut
        
        var matches = [Mission]()
        let allMissions: [Mission] = Bundle.main.decode("missions.json")
        
        for mission in allMissions {
            if let _ = mission.crew.first(where: {$0.name == astronaut.id}) {
                matches.append(mission)
            }
        }
        self.missions = matches
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static let astronaut: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let mission: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronaut[0], missions: mission)
    }
}
