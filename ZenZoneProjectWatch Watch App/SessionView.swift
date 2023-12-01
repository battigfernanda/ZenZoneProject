//
//  SessionView.swift
//  ZenZoneProjectWatch Watch App
//
//  Created by Fernanda Battig on 2023-12-01.
//

import SwiftUI

struct SessionListView: View {
    @State private var sessions: [MeditationSession] = MeditationDataLoader.loadMeditationSessions()

    var body: some View {
        List(sessions) { session in
            NavigationLink(destination: SessionDetailView(session: session)) {
                VStack(alignment: .leading) {
                    Text(session.title)
                        .fontWeight(.bold)
                    Text("Duration: \(session.duration) mins")
                        .font(.caption)
                }
            }
        }
    }
}

