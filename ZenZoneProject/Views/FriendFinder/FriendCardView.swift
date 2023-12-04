//
//  FriendCardView.swift
//  ZenZoneProject
//
//  Created by Fernando Molina on 2023-12-04.
//

import SwiftUI

struct FriendCardView: View {
    
    @State var dbHelper : FireDBHelper
    @State var activeUser : User
    @State var userBeingShown : User
    @State var isSuggestedFriendButtonEnabled : Bool = false
    
    var body: some View {
        VStack{
            Text("FRIEND:")
                .font(.title)
            Text(userBeingShown.firstName)
            Text(userBeingShown.lastName)
            Text(userBeingShown.username)
            Text(userBeingShown.email)
            
            Spacer()
            
            if(self.isSuggestedFriendButtonEnabled){
                Button(action: () ->
                       dbHelper.addFriend()
                ){
                    Text("Add '\(userBeingShown.firstName) \(userBeingShown.lastName)")
                }
            }
        } // Vstack - #1
    }// body
    
    private func addFriend(friend: User) -> Void {
        
    }
}
