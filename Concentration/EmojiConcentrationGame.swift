//
//  EmojiConcentrationGame.swift
//  EmojiConcentrationGame
//
//  Created by Trevor Schmidt on 9/7/21.
//

import Foundation
import SwiftUI

class EmojiConcentrationGame: ObservableObject {
    @Published private var game = createGame()
    
    static let emojis = ["🥨", "🥑", "🥭", "🌶", "🍕", "🍣"]
    
    static func createGame() -> ConcentrationGame<String>{
        return ConcentrationGame<String>(
            numberOfPairsOfCards: Int.random(in: 2...5)) { index in
            emojis[index]
        }
    }
    
    var cards: Array<ConcentrationGame<String>.Card> {
        game.cards
    }
    
    func choose(_ card: ConcentrationGame<String>.Card) {
        game.choose(card)
    }
}
