//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Trevor Schmidt on 9/7/21.
//

import SwiftUI

struct EmojiGameView: View {
    @ObservedObject var emojiGame: EmojiConcentrationGame
    
    var fontForGame: Font {
        emojiGame.cards.count < 10 ? .largeTitle : .body
    }
    
    var body: some View {
        HStack {
            ForEach(emojiGame.cards) { card in
                CardView(card: card, font: fontForGame)
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {
                        emojiGame.choose(card)
                    }
            }
        }
        .padding()
        .foregroundColor(.blue)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiGameView(emojiGame: EmojiConcentrationGame())
    }
}
