//
//  SoundPlayer.swift
//  Concentration
//
//  Created by Trevor Schmidt on 10/7/21.
//

import Foundation
import AVFoundation

struct SoundPlayer {
    var player: AVAudioPlayer?
    
    mutating func playSound(named soundName: String) {
        guard let path = Bundle.main.path(forResource: soundName, ofType: nil) else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            player?.play()
        } catch {
            // Ignore -- the sound just won't play
        }
    }
}
