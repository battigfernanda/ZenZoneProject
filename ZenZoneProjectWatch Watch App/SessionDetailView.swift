//
//  SessionDetailView.swift
//  ZenZoneProjectWatch Watch App
//
//  Created by Fernanda Battig on 2023-12-01.
//

import SwiftUI

struct SessionDetailView: View {
    let session: MeditationSession
    @StateObject private var mediaPlayer = MediaPlayer.shared

    var body: some View {
        ScrollView {
            VStack {
                Text(session.title)
                    .font(.headline)
                    .padding()

                Text(session.description)
                    .font(.caption)
                    .lineLimit(3)
                    .padding()

                
                Slider(value: $mediaPlayer.progress, in: 0...1, step: 0.01)

                // Play and stop buttons
                HStack {
                    Button(action: {
                        if mediaPlayer.isPlaying {
                            mediaPlayer.pauseAudio()
                        } else {
                            mediaPlayer.playAudio(file: session.audioFileName, ofType: "mp3")
                        }
                    }) {
                        Image(systemName: mediaPlayer.isPlaying ? "pause.circle" : "play.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    }

                    Button("Stop") {
                        mediaPlayer.stopAudio()
                    }
                    .padding()
                }
                .padding()
            }
        }
        .navigationTitle(Text(session.title))
        .onAppear {
            mediaPlayer.playAudio(file: session.audioFileName, ofType: "mp3")
        }
        .onDisappear {
            mediaPlayer.stopAudio()
        }
    }
}
