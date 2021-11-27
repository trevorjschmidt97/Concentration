//
//  CardView.swift
//  CardView
//
//  Created by Trevor Schmidt on 9/9/21.
//

import SwiftUI

struct CardView: View {
    var card: ConcentrationGame<String>.Card
    var type: ThemeType
    
    @State private var animatedBonusRemaining: Double = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                switch type {
                case .emoji:
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-animatedBonusRemaining)*360-90))
                                .onAppear {
                                    animatedBonusRemaining = card.bonusRemaining
                                    withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                        animatedBonusRemaining = 0
                                    }
                                }
                        } else {
                            if card.bonusRemaining == 1 {
                                Circle()
                            } else {
                                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-card.bonusRemaining)*360-90))
                            }
                        }
                    }
                        .padding(5)
                        .opacity(0.5)
                    
                    Text(card.content)
                        .rotationEffect(Angle(degrees: card.isMatched
                                              ? 360
                                              : 0))
                        .animation(card.isMatched
                                   ? .linear(duration: 1.0).repeatForever(autoreverses: false)
                                   : .default,
                                   value: card.isMatched)
                        .font(systemFont(for: geometry.size))
                    
                    
                case .temple:
                    Group {
                        GeometryReader { proxy in
                            if card.isConsumingBonusTime {
                                GasCan(startHeight: (1-animatedBonusRemaining) * proxy.size.height, endHeight: proxy.size.height)
                                    .onAppear {
                                        animatedBonusRemaining = card.bonusRemaining
                                        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                            animatedBonusRemaining = 0
                                        }
                                    
                                }
                            } else {
                                GasCan(startHeight: (1-card.bonusRemaining) * proxy.size.height, endHeight: proxy.size.height)
                            }
                        }
                    }
                        .opacity(0.5)
                        .cornerRadius(Constants.cornerRadius)
                    
                    Image(card.content)
                        .resizable()
                        .cornerRadius(10)
                        .padding(10)
                        .aspectRatio(1/1, contentMode: .fit)
                        .scaleEffect(card.isMatched ? 0.2 : 1)
                        .animation(card.isMatched
                                   ? .easeInOut(duration: 1.0).repeatForever(autoreverses: true)
                                   : .default,
                                   value: card.isMatched)
                case .shape:
                    Group {
                        GeometryReader { proxy in
                            if card.isConsumingBonusTime {
                                GasCan(startHeight: (1-animatedBonusRemaining) * proxy.size.height, endHeight: proxy.size.height)
                                    .onAppear {
                                        animatedBonusRemaining = card.bonusRemaining
                                        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                            animatedBonusRemaining = 0
                                        }
                                    
                                }
                            } else {
                                GasCan(startHeight: (1-card.bonusRemaining) * proxy.size.height, endHeight: proxy.size.height)
                            }
                        }
                    }
                        .opacity(0.5)
                        .cornerRadius(Constants.cornerRadius)
                    
                    let numSides = Int(card.content.split(separator: "-")[0])
                    let colorStr = String(card.content.split(separator: "-")[1])
                    if let numSides = numSides, let color = colorStr.string2color() {
                        PolygonShape(sides: numSides)
                            .fill(color)
                            .padding(5)
                            .aspectRatio(1/1, contentMode: .fit)
                            .rotationEffect(Angle(degrees: card.isMatched
                                                  ? 360
                                                  : 0))
                            .animation(card.isMatched
                                       ? .linear(duration: 1.0).repeatForever(autoreverses: false)
                                       : .default,
                                       value: card.isMatched)
                    }
                }
                
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }

    private func systemFont(for size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * Constants.fontScale)
    }
    
    // MARK: - Drawing Constants
    private struct Constants {
        static let cornerRadius: CGFloat = 10.0
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.70
        static let fontSize: CGFloat = 32
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(card: ConcentrationGame.Card(id: 3, content: "🍕"))
//    }
//}
