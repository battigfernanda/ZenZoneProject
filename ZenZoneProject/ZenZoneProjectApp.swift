//
//  ZenZoneProjectApp.swift
//  ZenZoneProject
//
//  Created by Fernanda Battig on 2023-11-25.
//

import SwiftUI
import Firebase
import UIKit

// Custom AppDelegate to handle specific app lifecycle events
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize Firebase
        FirebaseApp.configure()

        // Additional setup if needed
        return true
    }

    // Implement other necessary AppDelegate methods here
}

@main
struct ZenZone_DBApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
   

    var body: some Scene {
        WindowGroup {
            let user = FireDBHelper()

            // Your primary view
//            HomePageView()
            LaunchView().environmentObject(user)
        }
    }
}

