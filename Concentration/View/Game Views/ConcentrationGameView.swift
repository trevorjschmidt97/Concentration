//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Trevor Schmidt on 9/7/21.
//

import SwiftUI

struct ConcentrationGameView: View {
    @ObservedObject var gameViewModel: ConcentrationGameViewModel
    
    @State private var dealt: Set<UUID> = []
    @Namespace private var dealingNamespace
    @State private var playSound: Bool = false
    @State private var isEditing = false
    
    private func deal(_ card: ConcentrationGame<String>.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: ConcentrationGame<String>.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: ConcentrationGame<String>.Card) -> Animation {
        var delay = 0.0
        if let index = gameViewModel.cards.firstIndex(where: { $0.id == card.id }) {
            delay = (Double(index) + CardConstants.totalDealDuration) / Double(gameViewModel.cards.count)
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: ConcentrationGame<String>.Card) -> Double {
        -Double(gameViewModel.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                if gameViewModel.cards.allSatisfy{ card in isUndealt(card) } {
                    Stepper("Number of Cards: \(gameViewModel.numPairs * 2)",
                            value: $gameViewModel.numPairs,
                            in: 2...gameViewModel.theme.contents.count)
                }
                
                gameBody
                
                HStack {
                    soundButton
                    Spacer()
                    if gameViewModel.cards.allSatisfy { card in !isUndealt(card) } {
                        restartButton
                        Spacer()
                    }
                    shuffleButton
                }
            }
            deckBody
        }
        .padding()
        .navigationTitle("\(gameViewModel.theme.name)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Text("Score: \(gameViewModel.score)"))
        .onAppear(perform: {
            gameViewModel.onAppear()
        })
    }
    
    var gameBody: some View {
        AspectVGrid(items: gameViewModel.cards, aspectRatio: 2/3) { card in
            if isUndealt(card) || card.isMatched && !card.isFaceUp {
                Color.clear
            } else {
                CardView(card: card, type: gameViewModel.theme.type)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            gameViewModel.choose(card)
                        }
                    }
            }
        }
        .foregroundColor(color)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(gameViewModel.cards.filter(isUndealt)) { card in
                CardView(card: card, type: gameViewModel.theme.type)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(color)
        .onTapGesture {
            gameViewModel.playDealSound()
            gameViewModel.game = ConcentrationGameViewModel.createGame(theme: gameViewModel.game.theme, numberOfPairs: Int(gameViewModel.numPairs))
            for card in gameViewModel.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var soundButton: some View {
        Button {
            gameViewModel.toggleSound()
        } label: {
            Image(systemName: gameViewModel.soundOn ? "speaker.wave.3" : "speaker.slash")
        }
    }
    
    var shuffleButton: some View {
        Button {
            withAnimation {
                gameViewModel.shuffle()
            }
        } label: {
            Image(systemName: "shuffle")
        }
    }
    
    var restartButton: some View {
        Button {
            withAnimation {
                dealt = []
                gameViewModel.restart()
            }
        } label: {
            Image(systemName: "arrow.counterclockwise")
        }
    }
    
    var color: Color {
        gameViewModel.theme.color.string2color() ?? .red
    }
    
    private struct CardConstants {
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.4
        static let totalDealDuration: Double = 1.0
        static let undealtHeight: CGFloat = 90
        static let undealtWidth: CGFloat = undealtHeight * aspectRatio
    }
}

//
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        let game = EmojiConcentrationGame()
//        game.choose(game.cards.first!)
//        return EmojiGameView(emojiGame: game)
//    }
//}
