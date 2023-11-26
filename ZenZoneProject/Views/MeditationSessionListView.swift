//
//  MeditationSessionListView.swift
//  ZenZoneProject
//
//  Created by Fernanda Battig on 2023-11-25.
//

import SwiftUI

struct MeditationSessionListView: View {
    @State private var sessions: [MeditationSession] = []

    var body: some View {
        NavigationView {
            List(sessions) { session in
                NavigationLink(destination: MeditationSessionDetailView(session: session)) {
                    HStack {
                        Image(session.imageName) // Display the session's image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)

                        VStack(alignment: .leading) {
                            Text(session.title)
                                .fontWeight(.bold)
                            
                            // Removed the description from the list view
                            Text("Category: \(session.category)")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle("Meditation Sessions")
            .onAppear {
                // Load sessions from the MeditationDataLoader
                sessions = MeditationDataLoader.loadMeditationSessions()
            }
        }
    }
}

struct MeditationSessionListView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationSessionListView()
    }
}
