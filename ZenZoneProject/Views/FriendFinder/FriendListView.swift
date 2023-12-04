//
//  FriendListView.swift
//  ZenZoneProject
//
//  Created by Fernando Molina on 2023-12-04.
//

import SwiftUI

struct FriendListView: View {
    
    @State var friendsList : [User]
    @State var dbHelper : FireDBHelper
    
    var body: some View {
        VStack{
            Text("YOUR FRIENDS:")
            List{
                ForEach(0..<$friendsList.count) { index in
                    FriendCardView(dbHelper: dbHelper, activeUser: User, userBeingShown: friendsList[index], isSuggestedFriendButtonEnabled: false)
                }
            }// List - #1
            
            Text("RECOMMENDED FRIENDS:")
            List{
                ForEach(0..<$friendsList.count) { index in
                    FriendCardView(friend: friendsList[index], isSuggestedFriendButtonEnabled: true)
                }
            }// List - #2
        }// Vstack - #1
        .onAppear(){
            
            // load friends information from DB
            
        }
    }
}
