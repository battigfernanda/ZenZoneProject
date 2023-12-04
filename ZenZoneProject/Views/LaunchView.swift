//
//  LaunchView.swift
//  test
//
//  Created by Muhammad Haris on 28/11/2023.
//

import SwiftUI

struct LaunchView: View {
    

    @EnvironmentObject var user : FireDBHelper
    
    var body: some View {
        NavigationView{
            if user.userIsAuthenticatedAndSynced{
                    HomePageView()
            }else {
                SignupPage()
            }
            }
        }
    }


