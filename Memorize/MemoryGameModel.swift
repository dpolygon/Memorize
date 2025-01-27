//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Daniel Gonzalez on 7/18/24.
//  Synonymous with a model

import Foundation

struct MemoryGameModel<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private(set) var score: Int
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        score = 0
        
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "a\(pairIndex)"))
            cards.append(Card(content: content, id: "b\(pairIndex)"))
        }
        
        cards.shuffle()
    }
    
    private var theOnlyCardThatsUp: Int?
    
    mutating func choose(_ card: Card) {
        guard let index = cards.firstIndex(of: card) else { return }
        guard !cards[index].isFaceUp && !cards[index].isMatched else { return }
        if let IndexOfComparingCard = theOnlyCardThatsUp {
            if cards[index].content == cards[IndexOfComparingCard].content {
                cards[index].isMatched = true
                cards[IndexOfComparingCard].isMatched = true
                score += 2
            } else {
                score -= cards[index].seen ? (cards[IndexOfComparingCard].seen ? 2 : 1) : (cards[IndexOfComparingCard].seen ? 1 : 0)
                cards[index].seen = true
                cards[IndexOfComparingCard].seen = true
            }
            theOnlyCardThatsUp = nil
        } else {
            for index in cards.indices {
                cards[index].isFaceUp = false
            }
            theOnlyCardThatsUp = index
        }
        cards[index].isFaceUp = true
    }
    
//    mutating func newGame() {
//        for index in cards.indices {
//            cards[index].isFaceUp = false
//            cards[index].isMatched = false
//        }
//        cards.shuffle()
//    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var seen: Bool = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id): \(content) looking up -> \(isFaceUp) is matched -> \(isMatched)"
        }
    }
}
