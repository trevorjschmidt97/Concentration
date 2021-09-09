//
//  ConcentrationGame.swift
//  ConcentrationGame
//
//  Created by Trevor Schmidt on 9/7/21.
//

import Foundation
import SwiftUI

struct ConcentrationGame<CardContent> {
    var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        print("You chose \(card)")
        if let cardIndex = index(of: card) {
            cards[cardIndex].isFaceUp.toggle()
        }
    }
    
    func index(of targetCard: Card) -> Int? {
        for index in 0..<cards.count {
            if cards[index].id == targetCard.id {
                return index
            }
        }
        return nil
    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp = true
        var isMatched = false
        var content: CardContent
    }
}
