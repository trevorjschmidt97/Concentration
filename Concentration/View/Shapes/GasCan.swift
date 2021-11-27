//
//  GasCan.swift
//  Concentration
//
//  Created by Trevor Schmidt on 10/5/21.
//

import SwiftUI

struct GasCan: Shape {
    var startHeight: CGFloat
    var endHeight: CGFloat
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(startHeight, endHeight)
        }
        set {
            startHeight = CGFloat(newValue.first)
            endHeight = CGFloat(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let bottomRight = CGPoint(x: rect.maxX, y: startHeight)
        let bottomLeft = CGPoint(x: rect.minX, y: startHeight)
        let topRight = CGPoint(x: rect.maxX, y: endHeight)
        let topLeft = CGPoint(x: rect.minX, y: endHeight)
        
        var p = Path()
        p.move(to: bottomRight)
        p.addLine(to: bottomLeft)
        p.addLine(to: topLeft)
        p.addLine(to: topRight)
        p.addLine(to: bottomRight)
        return p
    }
}

struct GasCan_Previews: PreviewProvider {
    static var previews: some View {
        GasCan(startHeight: 300, endHeight: 150)
            .opacity(0.4)
            .foregroundColor(.orange)
    }
}
