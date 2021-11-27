////
////  ThemeListView.swift
////  ThemeListView
////
////  Created by Trevor Schmidt on 9/18/21.
////
//
//import SwiftUI
//
//
//// This stopped working, but I don't want to delete it
//struct ThemeListView: View {
//    var type: String
//    @State private var highScores: [String:Int]
//
//    init(type: String) {
//        self.type = type
//        self.highScores = ThemeListView.pullHighScores(themes: type == "Emoji Mojo" ? emojiThemes : templeThemes)
//    }
//
//    var body: some View {
//        List {
//            if type == "Emoji Mojo" {
//                ForEach(emojiThemes) { theme in
//                    NavigationLink {
//                        ConcentrationGameView(gameViewModel: ConcentrationGameViewModel(theme: theme))
//                    } label: {
//                        HStack {
//                            Text(theme.contents[0])
//                                .font(.title)
//                                .frame(width: 50, height: 50)
//                            VStack(alignment: .leading) {
//                                Text("\(theme.name)")
//                                    .foregroundColor(theme.color.string2color() ?? .black)
//                                    .font(.headline)
//                                if let highScore = highScores[theme.name] {
//                                    Text("High Score: \(highScore == 0 ? "Never played" : String(highScore))")
//                                        .font(.caption)
//                                }
//                                Text(theme.formattedContent.prefix(10))
//                            }
//                        }
//
//                    }
//                }
//            } else {
//                ForEach(templeThemes) { theme in
//                    NavigationLink {
//                        ConcentrationGameView(gameViewModel: ConcentrationGameViewModel(theme: theme))
//                    } label: {
//                        HStack {
//                            Image("\(theme.contents[0])")
//                                .resizable()
//                                .frame(width: 50, height: 50)
//                                .cornerRadius(10)
//                            VStack(alignment: .leading) {
//                                Text("\(theme.name)")
//                                    .font(.headline)
//
//                                if let highScore = highScores[theme.name] {
//                                    Text("High Score: \(highScore == 0 ? "Never played" : String(highScore))")
//                                        .font(.caption)
//                                }
//
//                            }
//                        }
//
//                    }
//                }
//            }
//
//        }
//        .navigationTitle("\(type)")
//        .onAppear {
//            highScores = ThemeListView.pullHighScores(themes: type == "Emoji Mojo" ? emojiThemes : templeThemes)
//        }
//    }
//
//    static func pullHighScores(themes: [Theme]) -> [String:Int] {
//        var output: [String: Int] = [:]
//        for theme in themes {
//            output[theme.name] = UserDefaults.standard.integer(forKey: theme.name)
//        }
//        return output
//    }
//}
