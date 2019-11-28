//
//  UserInfoView.swift
//  FriendFace_MILESTONE
//
//  Created by roblack on 11/28/19.
//  Copyright © 2019 roblack. All rights reserved.
//

import SwiftUI

struct UserInfoView: View {
    
    var currentUser: User
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Circle()
                    .frame(width: 16, height: 16)
                    .foregroundColor(currentUser.isActive ?? false ? .green : .red)
                Text(currentUser.name)
                    .font(.system(size: 40, weight: .bold))
                    .multilineTextAlignment(.center)
            }.lineLimit(nil)
            
            VStack(alignment: .center) {
                HStack {
                Image(systemName: "envelope.badge.fill")
                Text(currentUser.email)
                }
                HStack {
                Image(systemName: "house.fill")
                Text(currentUser.company)
                }
            }
            Spacer()
        }
    }
}


