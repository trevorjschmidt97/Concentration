//
//  CardView.swift
//  CardView
//
//  Created by Trevor Schmidt on 9/9/21.
//

import SwiftUI

struct CardView: View {
    var card: ConcentrationGame<String>.Card
    var font: Font
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: cardCornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cardCornerRadius).stroke()
                Text(card.content)
                    .font(font)
            } else {
                RoundedRectangle(cornerRadius: cardCornerRadius).fill()
            }
        }
    }
    
    // MARK: - Drawing Constants
    private let cardCornerRadius = 10.0
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: ConcentrationGame.Card(id: 3, content: "🍕"), font: .largeTitle)
    }
}
