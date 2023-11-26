//
//  MediaPlayer.swift
//  ZenZoneProject
//
//  Created by Fernanda Battig on 2023-11-25.
//

import Foundation
import AVFoundation
import Combine

class MediaPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    static let shared = MediaPlayer()
    
    private var audioPlayer: AVAudioPlayer?
    private var timer: Timer?
    
    
    @Published var isPlaying = false
    @Published var currentTime = TimeInterval(0)
    @Published var duration = TimeInterval(0)
    @Published var progress = Float(0) // Represents the audio progress as a percentage

    override private init() {
        super.init()
        configureAudioSession()
    }

    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session category. Error: \(error.localizedDescription)")
        }
    }

    func playAudio(file name: String, ofType type: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            print("Audio file not found")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.prepareToPlay()
            audioPlayer?.delegate = self
            audioPlayer?.play()
            isPlaying = true
            duration = audioPlayer?.duration ?? 0
            startTimer()
        } catch {
            print("Error playing audio file: \(error.localizedDescription)")
        }
    }

    func pauseAudio() {
        audioPlayer?.pause()
        isPlaying = false
        stopTimer()
    }

    func stopAudio() {
        audioPlayer?.stop()
        audioPlayer = nil
        isPlaying = false
        stopTimer()
        currentTime = 0
        progress = 0
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.updateAudioProgress()
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func updateAudioProgress() {
        currentTime = audioPlayer?.currentTime ?? 0
        progress = Float(currentTime / duration)
    }

    // MARK: - AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.isPlaying = false
            self?.stopTimer()
            self?.currentTime = 0
            self?.progress = 0
        }
    }

    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        DispatchQueue.main.async {
            print("Audio player decode error: \(error?.localizedDescription ?? "Unknown error")")
        }
    }
}
