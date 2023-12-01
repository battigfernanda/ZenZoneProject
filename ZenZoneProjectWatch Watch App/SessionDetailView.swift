//
//  SessionDetailView.swift
//  ZenZoneProjectWatch Watch App
//
//  Created by Fernanda Battig on 2023-12-01.
//

import SwiftUI

struct SessionDetailView: View {
    let session: MeditationSession
    @StateObject private var audioPlayerManager = AudioPlayerManager()

    var body: some View {
        ScrollView {
            VStack {
                Text(session.title)
                    .font(.headline)
                Text(session.description)
                    .font(.caption)
          

                Button("Play") {
                    audioPlayerManager.playAudio(fileName: session.audioFileName)
                }

                Button("Stop") {
                    audioPlayerManager.stopAudio()
                }
            }
        }
        .navigationTitle(session.title)
    }
}

