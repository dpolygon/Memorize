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
    var themes: [String: Theme] = [
        "Birthday": Theme(name: "Birthday",
                          symbol: "birthday.cake",
                          emoji: ["🥳", "🤩", "🎂", "🎉", "🎊", "🎁", "🎈", "💃", "🕺", "🎁", "💵"].shuffled(),
                          color: "lightblue"),
        "Earth": Theme(name: "Earth",
                       symbol: "leaf",
                       emoji: ["🌍", "🌱", "🌳", "🌿", "🍃", "🌾", "🌽", "🍎", "🍇", "🌊", "🐳", "🐬", "🦈", "🌄", "🌅", "🌇", "🌉"].shuffled(),
                       color: "blue"),
        "New Years": Theme(name: "New Years",
                           symbol: "fireworks",
                           emoji: ["🎆", "🥂", "🎉", "🕛", "🍾", "🎅", "🎄", "🥳", "🌟", "🎇"].shuffled(),
                           color: "red"),
        "Internet": Theme(name: "Internet",
                          symbol: "globe",
                          emoji: ["💬", "💭", "👥", "🌎", "🌏", "🌐", "📱", "💻", "📚", "💰", "🔗"].shuffled(),
                          color: "grey"),
        "Food": Theme(name: "Food",
                      symbol: "takeoutbag.and.cup.and.straw",
                      emoji: ["🥑", "🍅", "🥬", "🧊", "🍹", "🧉", "🥤", "🥩", "🍳", "🍕", "🍝", "🥓"].shuffled(),
                      color: "yellow"),
        "Space": Theme(name: "Space",
                       symbol: "moon.stars",
                       emoji: ["🚀", "👨‍🚀", "🌟", "👩‍🚀", "🌌", "👽", "🚀", "🌠", "🔭", "💫"].shuffled(),
                       color: "black")
    ]
    
    init() {
        self.model = MemoryGame.createGameModel(theme: themes.randomElement()!.value)
    }
        
    private static func createGameModel(theme: Theme) -> MemoryGameModel<String> {
        return MemoryGameModel(numberOfPairsOfCards: theme.emoji.count) { pairIndex in
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
    
    func shuffle() {
        model.shuffle()
    }
    
    func newGame() {
        model.newGame()
    }
    
    func choose(_ card: MemoryGameModel<String>.Card) {
        model.choose(card)
    }
}

struct Theme {
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
}
