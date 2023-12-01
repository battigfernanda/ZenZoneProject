//
//  AudioPlayerManager.swift
//  ZenZoneProjectWatch Watch App
//
//  Created by Fernanda Battig on 2023-12-01.
//


import AVFoundation


class AudioPlayerManager: ObservableObject {
    private var audioPlayer: AVPlayer?

    func playAudio(fileName: String) {
        guard let audioFileURL = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            return
        }

        // Initializing and playing the audio player
        audioPlayer = AVPlayer(url: audioFileURL)
        audioPlayer?.play()
    }

    func stopAudio() {
        audioPlayer?.pause()
    }
}


