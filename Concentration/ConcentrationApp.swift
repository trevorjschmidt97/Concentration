//
//  ConcentrationApp.swift
//  Concentration
//
//  Created by Trevor Schmidt on 9/7/21.
//

import SwiftUI

@main
struct ConcentrationApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MainMenuView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    static func getRandomEmojiArray() -> Array<String> {
        var emojiSet: Set<String> = []
        while emojiSet.count < 30 {
            emojiSet.insert(String(UnicodeScalar(Array(0x1F300...0x1F3F0).randomElement()!)!))
        }
        return Array(emojiSet)
    }
    
    static func randomColorString() -> String {
        return ["red",
                "blue",
                "cyan",
                "blue",
                "green",
                "yellow",
                "black",
                "orange",
                "gray",
                "teal"].randomElement() ?? "red"
    }
}
