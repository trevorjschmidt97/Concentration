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
            EmojiGameView(emojiGame: EmojiConcentrationGame())
        }
    }
}
