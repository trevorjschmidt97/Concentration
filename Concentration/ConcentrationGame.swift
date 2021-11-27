//
//  ConcentrationGame.swift
//  ConcentrationGame
//
//  Created by Trevor Schmidt on 9/7/21.
//

import Foundation
import SwiftUI

struct ConcentrationGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    var score: Int
    private var seenCards: Set<Int>
    private(set) var theme: Theme
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    init(numberOfPairsOfCards: Int, theme: Theme, cardContentFactory: (Int) -> CardContent) {
        cards = []//.removeAll()
        score = 0
        seenCards = []
        self.theme = theme
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: UUID(), isMatched: false, content: content))
            cards.append(Card(id: UUID(), isMatched: false, content: content))
        }
        cards.shuffle()
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched
        {
            // if a card is already up
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                // if the cards match
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    score += Int(ceil(cards[chosenIndex].bonusRemaining * 100 + cards[potentialMatchIndex].bonusRemaining * 100))
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                seenCards.insert(potentialMatchIndex)
                seenCards.insert(chosenIndex) // now it's in the set
                cards[chosenIndex].isFaceUp = true
            } else { // if there is no cards faced up
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        let id: UUID
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool {
            didSet {
                stopUsingBonusTime()
            }
        }
        let content: CardContent
        
        
        // MARK: - time stuff
        var bonusTimeLimit: TimeInterval = 6
        
        private var faceUpTime: TimeInterval {
            if let pastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(pastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        var hasEarnedMatch: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
