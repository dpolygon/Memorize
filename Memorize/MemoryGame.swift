//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Daniel Gonzalez on 7/18/24.
//  Synonymous with ViewModel link between model <-> UI

import SwiftUI


//@State var theme: [String]
//@State var currentTheme: String

class MemoryGame: ObservableObject {
    @Published private var model: MemoryGameModel<String>
    private(set) var currentTheme: String
    private var themes: [String: Theme] = [
        "Birthday": Theme(name: "Birthday",
                          symbol: "birthday.cake",
                          emoji: ["🥳", "🤩", "🎂", "🎉", "🎊", "🎁", "🎈", "💃", "🕺", "💵"],
                          color: "green"),
        "Earth": Theme(name: "Earth",
                       symbol: "leaf",
                       emoji: ["🌍", "🌱", "🌳", "🌿", "🍃", "🌾", "🌽", "🍎", "🍇", "🌊", "🐳", "🐬", "🦈", "🌄", "🌅", "🌇", "🌉"],
                       color: "blue"),
        "New Years": Theme(name: "New Years",
                           symbol: "fireworks",
                           emoji: ["🎆", "🥂", "🎉", "🕛", "🍾", "🎅", "🎄", "🥳", "🌟", "🎇"],
                           color: "red"),
        "Internet": Theme(name: "Internet",
                          symbol: "globe",
                          emoji: ["💬", "💭", "👥", "🌎", "🌏", "🌐", "📱", "💻", "📚", "💰", "🔗"],
                          color: "gray"),
        "Food": Theme(name: "Food",
                      symbol: "takeoutbag.and.cup.and.straw",
                      emoji: ["🥑", "🍅", "🥬", "🧊", "🍹", "🧉", "🥤", "🥩", "🍳", "🍕", "🍝", "🥓"],
                      color: "yellow"),
        "Space": Theme(name: "Space",
                       symbol: "moon.stars",
                       emoji: ["🚀", "👨‍🚀", "🌟", "👩‍🚀", "🌌", "👽", "🌠", "🔭", "💫"],
                       color: "black")
    ]
    
    func getColor() -> Color {
        let color: String = themes[currentTheme]!.color
        switch color {
        case "green":
            return .green
        case "blue":
            return .blue
        case "red":
            return .red
        case "gray":
            return .gray
        case "yellow":
            return .yellow
        case "black":
            return .black
        default:
            return .orange
        }
    }
    
    func getThemes() -> [Theme] {
        var outthemes: [Theme] = []
        for theme in themes {
            outthemes.append(theme.value)
        }
        return outthemes
    }
    
    init() {
        let theme = themes.randomElement()!.value
        currentTheme = theme.name
        self.model = MemoryGame.createGameModel(with: theme)
    }
        
    private static func createGameModel(with theme: Theme) -> MemoryGameModel<String> {
        return MemoryGameModel(numberOfPairsOfCards: 10) { pairIndex in
            if theme.emoji.indices.contains(pairIndex) {
                return theme.emoji[pairIndex]
            } else {
                return "⚠️"
            }
        }
    }
    
    var cards: Array<MemoryGameModel<String>.Card> {
        return model.cards
    }
    
    // MARK: - User Intents
    
    func newTheme(with theme: String) {
        currentTheme = theme
        self.model = MemoryGame.createGameModel(with: self.themes[theme]!)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func newGame() {
        let theme = themes.randomElement()!.value
        currentTheme = theme.name
        self.model = MemoryGame.createGameModel(with: theme)
    }
    
    func choose(_ card: MemoryGameModel<String>.Card) {
        model.choose(card)
    }
}

struct Theme: Identifiable {
    var name: String
    var symbol: String
    var emoji: [String]
    var numOfPairs: Int
    var color: String
    
    init(name: String, symbol: String, emoji: [String], color: String) {
        self.name = name
        self.symbol = symbol
        self.emoji = emoji
        self.numOfPairs = 9
        self.color = color
    }
    
    var id = UUID()
}
