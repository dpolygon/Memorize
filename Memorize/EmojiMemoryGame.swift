//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Daniel Gonzalez on 7/18/24.
//  Synonymous with ViewModel link between model <-> UI

import SwiftUI

let halloweenTheme = ["💀", "🎃", "👻", "😈", "👹", "🕷️", "🕸️", "👽", "🧛🏼‍♂️"]
let birthdayTheme = ["😘", "🎉", "🎂", "🥳", "🎈", "🎊", "🎁", "🪅", "🍾", "👏🏼"]
let christmasTheme = ["🎄", "🎅", "🇨🇽", "🤶", "🧑‍🎄", "❄️", "🌲", "☃️", "🗻", "🧤", "🧣"]

//@State var theme: [String]
//@State var currentTheme: String

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["💀", "🎃", "👻", "😈", "👹", "🕷️", "🕸️", "👽", "🧛🏼‍♂️"]
        
    private static func createGameModel() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: emojis.count) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "cotent could not generate"
            }
        }
    }
    
    @Published private var model = createGameModel()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: User Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func newGame() {
        model.newGame()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
