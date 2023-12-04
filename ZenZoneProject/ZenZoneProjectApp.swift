//
//  ZenZoneProjectApp.swift
//  ZenZoneProject
//
//  Created by Fernanda Battig on 2023-11-25.
//

import SwiftUI
import Firebase
import UIKit

@main
struct ZenZone_DBApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    //    @UIApplicationDelegateAdaptor{AppDelegate.self} var appDelegate
    var body: some Scene {
        WindowGroup {
            let user = FireDBHelper()
            LaunchView().environmentObject(user)
                
        }
    }
}
