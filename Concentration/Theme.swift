//
//  Theme.swift
//  Concentration
//
//  Created by Trevor Schmidt on 10/4/21.
//

import Foundation

enum ThemeType {
    case emoji
    case temple
    case shape
}

struct Theme: Identifiable {
    var id: String {
        self.name
    }
    var name: String
    var contents: [String]
    var color: String
    var highScore: Int {
        UserDefaults.standard.integer(forKey: name)
    }
    var type: ThemeType
    
    var formattedContent: String {
        var temp = ""
        var count = 0
        for content in contents {
            if count != 0 {
                temp += content
            }
            count += 1
        }
        return temp
    }
}

var emojiThemes: [Theme] = [
    Theme(name: "Halloween",
          contents: ["💀", "👻", "🎃", "🥸", "😈", "👹", "👺", "👮🏻‍♂️", "🧑🏻‍🎄", "🥷🏻", "🦇", "🌚"],
          color: "orange",
          type: .emoji),
    Theme(name: "Christmas",
          contents: ["🎄", "🎅🏼", "🤶🏼", "🧑🏻‍🎄", "⭐️", "🎁", "❄️", "☃️", "⛷", "🛷", "🦌"],
          color: "green",
          type: .emoji),
    Theme(name: "Food",
          contents: ["🍏", "🍊", "🍌", "🍉", "🥩", "🍟", "🍕", "🌭", "🌮", "🌯", "🍣", "🍩"],
          color: "yellow",
          type: .emoji),
    Theme(name: "Sports",
          contents: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🏐", "🥏", "🎱", "🏓", "🥍", "🥊", "🏋🏻‍♀️"],
          color: "blue",
          type: .emoji),
    Theme(name: "Flags",
          contents: ["🏴‍☠️", "🏳️‍🌈", "🇧🇷", "🇯🇵", "🇺🇸", "🇺🇾", "🇦🇶", "🇦🇺", "🇧🇴", "🇨🇦", "🇩🇰"],
          color: "teal",
          type: .emoji),
    Theme(name: "Random",
          contents: ConcentrationApp.getRandomEmojiArray(),
          color: ConcentrationApp.randomColorString(),
          type: .emoji)
]



var templeThemes: [Theme] = [
    Theme(name: "North American Temples",
          contents: [
            "1-salt-lake-temple-300x300",
            "2-meridian-temple-300x300",
            "3-sandiego-temple-300x300",
            "4-provo-city-center-temple-300x300",
            "6-gilbert-temple-300x300",
            "7-washington-dc-temple-300x300",
            "8-tucson-temple-300x300"
          ],
          color: "yellow",
          type: .temple),
    Theme(name: "Utah Temples",
          contents: [
            "17-provo-utah-temple-300x300",
            "1-salt-lake-temple-300x300",
            "4-provo-city-center-temple-300x300",
            "10-payson-temple-300x300",
            "11-ogden-utah-temple-300x300",
            "12-draper-temple-300x300",
            "13-manti-utah-temple-300x300"
          ],
          color: "cyan",
          type: .temple),
    Theme(name: "Random Temples",
          contents: [
            "1-salt-lake-temple-300x300",
            "2-meridian-temple-300x300",
            "3-sandiego-temple-300x300",
            "4-provo-city-center-temple-300x300",
            "5-laie-temple-300x300",
            "6-gilbert-temple-300x300",
            "7-washington-dc-temple-300x300",
            "8-tucson-temple-300x300",
            "9-rexburg-temple-300x300",
            "10-payson-temple-300x300",
            "11-ogden-utah-temple-300x300",
            "12-draper-temple-300x300",
            "13-manti-utah-temple-300x300",
            "14-fort-collins-temple-300x300",
            "15-philadelphia-temple-300x300",
            "16-nauvoo-temple-300x300",
            "17-provo-utah-temple-300x300",
            "18-mesa-temple-300x300",
            "19-albuquerque-temple-300x300",
            "20-st-george-temple-300x300",
            "21-newport-beach-temple-300x300",
            "22-rome-temple-300x300",
            "23-manhattan-temple-300x300",
            "24-las-vegas-temple-300x300",
            "25-boise-temple-300x300",
            "26-columbia-river-temple-300x300",
            "27-kirtland-temple-300x300"
          ].shuffled(),
          color: ConcentrationApp.randomColorString(),
          type: .temple)
]

var shapeThemes: [Theme] = [
    Theme(name: "Shape Scape",
          contents: [
                "4-blue",
                "6-blue",
                "4-red",
                "6-red",
                "4-green",
                "6-green",
                "4-yellow",
                "6-yellow"],
           color: "grey",
           type: .shape)
]

