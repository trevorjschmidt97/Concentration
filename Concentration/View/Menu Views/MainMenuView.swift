//
//  MainMenuView.swift
//  Concentration
//
//  Created by Trevor Schmidt on 10/4/21.
//

import SwiftUI

struct MainMenuView: View {
    @State private var highScores: [String:Int]
    @State private var emojiExpanded = true
    @State private var templeExpanded = true
    @State private var shapeExpanded = true
    
    
    init() {
        self.highScores = MainMenuView.pullHighScores()
    }
    
    var body: some View {
        Form {
            
            DisclosureGroup("Emoji Mojo \(highScores["emojiMax"] ?? 0 == 0 ? "" : "(High Score: " + String(highScores["emojiMax"] ?? 0) + ")")", isExpanded: $emojiExpanded) {
                ForEach(emojiThemes) { theme in
                    NavigationLink {
                        ConcentrationGameView(gameViewModel: ConcentrationGameViewModel(theme: theme))
                    } label: {
                        HStack {
                            Text(theme.contents[0])
                                .font(.title)
                                .frame(width: 50, height: 50)
                            VStack(alignment: .leading) {
                                Text("\(theme.name)")
                                    .foregroundColor(theme.color.string2color() ?? .primary)
                                    .font(.headline)
                                if let highScore = highScores[theme.name] {
                                    Text("High Score: \(highScore == 0 ? "Never played" : String(highScore))")
                                        .font(.caption)
                                }
                                Text(theme.formattedContent.prefix(8))
                            }
                        }
                        
                    }
                }
            }
            
            DisclosureGroup("Temple Match \(highScores["templeMax"] ?? 0 == 0 ? "" : "(High Score: " + String(highScores["templeMax"] ?? 0) + ")")", isExpanded: $templeExpanded) {
                ForEach(templeThemes) { theme in
                    NavigationLink {
                        ConcentrationGameView(gameViewModel: ConcentrationGameViewModel(theme: theme))
                    } label: {
                        HStack {
                            Image("\(theme.contents[0])")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                            VStack(alignment: .leading) {
                                Text("\(theme.name)")
                                    .font(.headline)
                                    .foregroundColor(theme.color.string2color() ?? .primary)
                                
                                if let highScore = highScores[theme.name] {
                                    Text("High Score: \(highScore == 0 ? "Never played" : String(highScore))")
                                        .font(.caption)
                                }
                                
                            }
                        }
                        
                    }
                }
            }
                 
            DisclosureGroup("Shape Scape \(highScores["shapeMax"] ?? 0 == 0 ? "" : "(High Score: " + String(highScores["shapeMax"] ?? 0) + ")")", isExpanded: $shapeExpanded) {
                ForEach(shapeThemes) { theme in

                    NavigationLink {
                        ConcentrationGameView(gameViewModel: ConcentrationGameViewModel(theme: theme))
                    } label: {
                        HStack {
                            Image(systemName: "star")
                                .font(.title)
                                .frame(width: 50, height: 50)

                            VStack(alignment: .leading) {
                                Text("Shape Scape")
                                    .font(.headline)
                                    .foregroundColor(theme.color.string2color() ?? .primary)

                                if let highScore = highScores[theme.name] {
                                    Text("High Score: \(highScore == 0 ? "Never played" : String(highScore))")
                                        .font(.caption)
                                }
                            }
                        }
                    }
                }
            }
                
            
        }
        .navigationTitle("Concentration Games")
        .onAppear {
            highScores = MainMenuView.pullHighScores()
        }

    }
    

    
    static func pullHighScores() -> [String:Int] {
        var output: [String: Int] = [:]
        for theme in emojiThemes {
            output[theme.name] = UserDefaults.standard.integer(forKey: theme.name)
            if let emojiMax = output["emojiMax"] {
                output["emojiMax"] = max(emojiMax, UserDefaults.standard.integer(forKey: theme.name))
            } else {
                output["emojiMax"] = UserDefaults.standard.integer(forKey: theme.name)
            }
        }
        for theme in templeThemes {
            output[theme.name] = UserDefaults.standard.integer(forKey: theme.name)
            if let templeMax = output["templeMax"] {
                output["templeMax"] = max(templeMax, UserDefaults.standard.integer(forKey: theme.name))
            } else {
                output["templeMax"] = UserDefaults.standard.integer(forKey: theme.name)
            }
        }
        for theme in shapeThemes {
            output[theme.name] = UserDefaults.standard.integer(forKey: theme.name)
            if let shapeMax = output["shapeMax"] {
                output["shapeMax"] = max(shapeMax, UserDefaults.standard.integer(forKey: theme.name))
            } else {
                output["shapeMax"] = UserDefaults.standard.integer(forKey: theme.name)
            }
        }
        return output
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
