//
//  Color+String.swift
//  Concentration
//
//  Created by Trevor Schmidt on 10/4/21.
//

import Foundation
import SwiftUI

extension String {
    
    
    func string2color() -> Color? {
        switch self {
        case "red":
            return Color.red
        case "blue":
            return Color.blue
        case "green":
            return Color.green
        case "yellow":
            return Color.yellow
        case "black":
            return Color.black
        case "orange":
            return Color.orange
        case "white":
            return Color.white
        case "cyan":
            return Color.cyan
        case "teal":
            return Color.teal
        case "grey":
            return Color.gray
        case "random":
            return [Color.red,
                    Color.blue,
                    Color.cyan,
                    Color.blue,
                    Color.green,
                    Color.yellow,
                    Color.black,
                    Color.orange,
                    Color.gray,
                    Color.teal].randomElement() ?? .red
        default:
                return nil
        }
    }
}
