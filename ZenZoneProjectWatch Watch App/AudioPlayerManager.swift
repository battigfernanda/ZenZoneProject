//
//  AudioPlayerManager.swift
//  ZenZoneProjectWatch Watch App
//
//  Created by Fernanda Battig on 2023-12-01.
//


import AVFoundation
import Combine

class AudioPlayerManager: ObservableObject {
    private var audioPlayer: AVPlayer?
    private var playerItem: AVPlayerItem?
    private var audioSession = AVAudioSession.sharedInstance()
    private var playerStatusObserver: AnyCancellable?

    init() {
        
        do {
            try audioSession.setCategory(.playback)
        } catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
    }

    func playAudio(file name: String, ofType type: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            print("Audio file not found")
            return
        }

        
        let audioFileURL = URL(fileURLWithPath: path)

   
        playerItem = AVPlayerItem(url: audioFileURL)
        audioPlayer = AVPlayer(playerItem: playerItem)

       
        playerStatusObserver = NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime, object: playerItem)
            .sink(receiveValue: { [weak self] _ in
                self?.playerDidFinishPlaying()
            })
        audioPlayer?.play()
    }

    func stopAudio() {
        audioPlayer?.pause()
        playerStatusObserver?.cancel()
    }

    private func playerDidFinishPlaying() {
        print("Playback finished.")
        
    }
}
