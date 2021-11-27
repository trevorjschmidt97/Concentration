//
//  TempleMatch.swift
//  Concentration
//
//  Created by Trevor Schmidt on 10/4/21.
//

import SwiftUI

struct TempleMatch: View {
    @State private var highScores: [String:Int] = pullHighScores(themes: templeThemes)
    
    static func pullHighScores(themes: [Theme]) -> [String:Int] {
        var output: [String: Int] = [:]
        for theme in themes {
            output[theme.name] = UserDefaults.standard.integer(forKey: theme.name)
        }
        return output
    }
    
    var body: some View {
        List {
            ForEach(templeThemes) { theme in
                NavigationLink {
                    ConcentrationGameView(gameViewModel: ConcentrationGameViewModel(theme: theme), numPairs: theme.contents.count)
                } label: {
                    HStack {
                        Image("\(theme.contents[0])")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                        VStack(alignment: .leading) {
                            Text("\(theme.name)")
                                .font(.headline)
                            
//                            Text("High Score: \(UserDefaults.standard.integer(forKey: theme.name) == 0 ? "Never played" : String(UserDefaults.standard.integer(forKey: theme.name)))")
                            
                            if let highScore = highScores[theme.name] {
                                Text("High Score: \(highScore == 0 ? "Never played" : String(highScore))")
                                    .font(.caption)
                            }
                            
                        }
                    }
                    
                }
            }
        }
        .navigationTitle("Temple Match")
        .onAppear {
            highScores = ThemeListView.pullHighScores(themes: templeThemes)
        }
    }
}

struct TempleMatch_Previews: PreviewProvider {
    static var previews: some View {
        TempleMatch()
    }
}
