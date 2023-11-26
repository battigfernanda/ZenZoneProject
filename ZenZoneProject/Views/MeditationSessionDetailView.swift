//
//  MeditationSessionDetailView.swift
//  ZenZoneProject
//
//  Created by Fernanda Battig on 2023-11-25.
//

import SwiftUI
import AVFoundation

struct MeditationSessionDetailView: View {
    let session: MeditationSession

    @StateObject private var mediaPlayer = MediaPlayer.shared

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(session.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(10)
                    .shadow(radius: 5)

                Text(session.title)
                    .font(.title)
                    .fontWeight(.bold)

                Text(session.description)
                    .font(.body)
                    .foregroundColor(.secondary)

                HStack {
                    Text("Duration: \(session.duration) mins")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Spacer()

                    Text("Category: \(session.category)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                // Audio player controls
                VStack {
                    Button(action: {
                        if mediaPlayer.isPlaying {
                            mediaPlayer.pauseAudio()
                        } else {
                            mediaPlayer.playAudio(file: session.audioFileName, ofType: "mp3")
                        }
                    }) {
                        Label(mediaPlayer.isPlaying ? "Pause Session" : "Play Session", systemImage: mediaPlayer.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                            .labelStyle(TitleOnlyLabelStyle())
                            .font(.title)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }

                    // Progress slider reflecting the audio progress
                    Slider(value: $mediaPlayer.progress, in: 0...1, step: 0.01)
                        .padding()
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle(Text(session.title), displayMode: .inline)
        .onAppear {
            // Playing the selected session audio when the view appears
            mediaPlayer.playAudio(file: session.audioFileName, ofType: "mp3")
        }
        .onDisappear {
            // Stoping the audio when the view disappears
            mediaPlayer.stopAudio()
        }
    }
}

struct MeditationSessionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationSessionDetailView(session: MeditationSession(id: "1", title: "Mountain Meditation", description: "This is a sample description for a meditation session.", duration: 8.13, category: "Relaxation", audioFileName: "MountainMeditation", imageName: "meditation_icon"))
    }
}


