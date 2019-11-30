//
//  UserDetailView.swift
//  FriendFace_MILESTONE
//
//  Created by roblack on 11/28/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct UserDetailView: View {
    
    var allUsers: [User]
    var currentUser: User
    var friends: [Friend]
    
    @State private var showingInfo : Bool = false
    @State private var selectedUser: User = nil
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .frame(width: 16, height: 16)
                    .foregroundColor(currentUser.isActive ?? false ? .green : .red)
                Text(currentUser.name)
                    .font(.system(size: 40, weight: .bold))
                    .multilineTextAlignment(.center)
            }.lineLimit(nil)
            
            HStack(alignment: .center) {
                HStack {
                Image(systemName: "envelope.badge.fill")
                Text(currentUser.email)
                }
                HStack {
                Image(systemName: "house.fill")
                Text(currentUser.company)
                }
            }.padding()
            
            HStack {
                ForEach(currentUser.tags, id: \.self) { tag in
                    Text("  \(tag)  ")
                    .lineLimit(1)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }.padding()
            
            List(friends, id: \.id) { friend in
                ForEach(self.allUsers) { user in
                    if user.id == friend.id {
                        HStack {
                        Circle()
                            .frame(width: 16, height: 16)
                            .foregroundColor(user.isActive ?? false ? .green : .red)
                        Text(user.name)
                            .onTapGesture {
                                self.selectedUser = user
                                self.showingInfo.toggle()
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showingInfo) {
            UserInfoView(currentUser: self.selectedUser!)
        }
    }
}

