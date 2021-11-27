//
//  PolygonShape.swift
//  Concentration
//
//  Created by Trevor Schmidt on 10/4/21.
//

import SwiftUI
struct PolygonShape: Shape {
  var sides: Int
  func path(in rect: CGRect) -> Path {
    // Hypotenuse
    let h = Double(min(rect.size.width, rect.size.height)) / 2.0
    // Center
    let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
    var p = Path()
    for i in 0..<sides {
      let angle = (Double(i) * (360.0 / Double(sides))) * Double.pi / 180
      // Calculate Vertex Position
      let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
      if i == 0 {
        p.move(to: pt) // move to first vertex
      } else {
        p.addLine(to: pt) // draw line to next vertex
      }
    }
    p.closeSubpath()
    return p
  }
}
struct PolygonShape_Previews: PreviewProvider {
  static var previews: some View {
    PolygonShape(sides: 3).fill(.green)
  }
}
