//
//  ContentView.swift
//  FriendFace_MILESTONE
//
//  Created by roblack on 11/26/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(entity: UserCD.entity(), sortDescriptors: []) var usersCD: FetchedResults<UserCD>
    
    @State var users = [User]()
    
    var body: some View {
        NavigationView {
        List(users, id: \.id) { user in
            NavigationLink(destination: UserDetailView(allUsers: self.users, currentUser: user, friends: user.friends)){
                HStack {
                Circle()
                    .frame(width: 16, height: 16)
                    .foregroundColor(user.isActive ?? false ? .green : .red)
                Text(user.name)
                }
            }
        }.onAppear(perform: fetchData)
        .navigationBarTitle("FriendFace")
        }.accentColor(.white)
    }
}


// MARK: ContenView Functions -----------------------------------------------------------------
extension ContentView {
    
    func fetchData() {
//        print("Users are: \(usersCD)")
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                    DispatchQueue.main.async {
                        self.users = decodedResponse
                    }
                    return
                }
            }
            print("Fetch Failed \(error?.localizedDescription  ?? "Unknown Error")")
        }.resume()
    }
}
