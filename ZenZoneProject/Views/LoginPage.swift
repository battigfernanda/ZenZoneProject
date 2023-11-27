//
//  LoginPage.swift
//  ZenZoneProject
//
//  Created by Fernanda Battig on 2023-11-26.
//

// FOR HARIS - ADD AUTHENTICATION AND HANDLE REQUESTS VIA FIREBASE

import SwiftUI

// Define an enum for navigation
enum NavigationItem: Hashable {
    case profilePage
}

struct LoginPage: View {
    @State private var email = ""
    @State private var password = ""
    @State private var navigationItem: NavigationItem?

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Login") {
                    // Authentication logic goes here
                    // On success, trigger navigation
                    self.navigationItem = .profilePage
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)

                if let navigationItem = navigationItem {
                    NavigationLink(value: navigationItem) {
                        EmptyView()
                    }
                }
            }
            .navigationDestination(for: NavigationItem.self) { item in
                switch item {
                case .profilePage:
                    ProfilePage()
                }
            }
            .navigationBarTitle("Login", displayMode: .inline)
        }
    }
}



struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
