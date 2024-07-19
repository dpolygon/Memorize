//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Daniel Gonzalez on 7/17/24.
//  Synonymous with the UI

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            cards
            Button("Shuffle") {
                viewModel.shuffle()
            }
//            HStack {
//                themeButtons
//            }
        }.padding()
    }
    
    var cards: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 120), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards.indices, id: \.self) { index in
                    CardView(viewModel.cards[index])
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                }
            }
        }
    }
    
//    func cardThemeButton(with Theme: [String], Symbol: String, Label: String) -> some View {
//        Button {
//            self.theme = (Theme + Theme).shuffled()
//            self.currentTheme = Label
//        } label: {
//            VStack {
//                Image(systemName: Symbol)
//                    .imageScale(.large)
//                    .font(.title)
//                Text(Label)
//                    .font(.caption)
//            }
//        }.disabled(currentTheme == Label)
//    }
//    
//    var themeButtons: some View {
//        HStack {
//            cardThemeButton(with: birthdayTheme, Symbol: "sun.max.circle.fill", Label: "Birthday")
//            cardThemeButton(with: christmasTheme, Symbol: "gift.circle.fill", Label: "Christmas")
//            cardThemeButton(with: halloweenTheme, Symbol: "moon.dust.circle.fill", Label: "Halloween")
//        }
//    }
    
//    func cardAdjusterButton(by offset: Int, Symbol: String) -> some View {
//        Button {
//            numOfCards += offset
//        } label: {
//            Image(systemName: Symbol)
//        }.disabled(numOfCards + offset == 0 || numOfCards + offset > halloweenTheme.count)
//    }
//    
//    var addCardButton: some View {
//        cardAdjusterButton(by: +1, Symbol: "plus.circle")
//    }
//    
//    var removeCardButton: some View {
//        cardAdjusterButton(by: -1, Symbol: "minus.circle")
//    }
//    
//    var cardAdjusters: some View {
//        HStack {
//            removeCardButton
//            addCardButton
//        }
//            .imageScale(.large)
//            .font(.title3)
//    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.orange)
                .opacity(card.isFaceUp ? 0 : 1)
            Group {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .strokeBorder(lineWidth: 2)
                    .foregroundStyle(.orange)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }.opacity(card.isFaceUp ? 1 : 0)
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
