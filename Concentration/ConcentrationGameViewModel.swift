//
//  EmojiConcentrationGame.swift
//  EmojiConcentrationGame
//
//  Created by Trevor Schmidt on 9/7/21.
//

import Foundation
import SwiftUI

class ConcentrationGameViewModel: ObservableObject {
    @Published var game: ConcentrationGame<String>
    @Published var soundOn: Bool = false
    @Published var numPairs: Int
    private var player = SoundPlayer()
    
    init(theme: Theme) {
        game = ConcentrationGameViewModel.createGame(theme: theme, numberOfPairs: theme.contents.count)
        numPairs = min(theme.contents.count, 12)
    }
    
    func onAppear() {
        soundOn = UserDefaults.standard.bool(forKey: "soundOn")
    }
    
    static func createGame(theme: Theme, numberOfPairs: Int) -> ConcentrationGame<String>{
        let shuffledEmojis = theme.contents.shuffled()
        return ConcentrationGame<String>(
            numberOfPairsOfCards: numberOfPairs, theme: theme) { index in
            shuffledEmojis[index]
        }
    }
    
    var score: Int {
        game.score
    }
    
    var cards: Array<ConcentrationGame<String>.Card> {
        game.cards
    }
    
    var theme: Theme {
        game.theme
    }
    
    func choose(_ card: ConcentrationGame<String>.Card) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred(intensity: 1.0)
        let oldHighScore = UserDefaults.standard.integer(forKey: theme.name)
        game.choose(card)
        let newScore = score
        if newScore > oldHighScore {
            UserDefaults.standard.set(newScore, forKey: theme.name)
        }
        if soundOn {
            if newScore > oldHighScore {
                UserDefaults.standard.set(newScore, forKey: theme.name)
                player.playSound(named: "boing.mp3")
            } else {
                player.playSound(named: "aoga.mp3")
            }
        }
    }
    
    func toggleSound() {
        soundOn.toggle()
        UserDefaults.standard.set(soundOn, forKey: "soundOn")
    }
    
    func playDealSound() {
        if soundOn {
            player.playSound(named: "shuffling-cards-2.mp3")
        }
    }
    
    func shuffle() {
        game.shuffle()
    }
    
    func restart() {
        game = ConcentrationGameViewModel.createGame(theme: game.theme, numberOfPairs: theme.contents.count)
    }
}
