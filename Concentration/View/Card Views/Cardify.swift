//
//  Cardify.swift
//  Cardify
//
//  Created by Trevor Schmidt on 9/9/21.
//

import Foundation
import SwiftUI

struct Cardify: AnimatableModifier {
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    var rotation: Double // Degrees
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill(Color.white).foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
            } else {
                shape.fill()
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle(degrees: rotation), axis: (0, 1, 0))
    }
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10.0
        static let lineWidth: CGFloat = 3
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
