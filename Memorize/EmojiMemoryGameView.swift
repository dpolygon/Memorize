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
            cards
            HStack {
                themes
                Spacer()
                Button("New Game") {
                    viewModel.newGame()
                }
                    .font(.title2)
                    .buttonStyle(.bordered)
            }
        }.padding()
    }
    
    func createThemeButtons(title: String, icon: String) -> some View{
        Button {
            
        } label: {
            VStack {
                Image(systemName: icon).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text(title).font(.caption)
            }
        }
            .padding(.leading)
    }
    
    var themes: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .bottom) {
                createThemeButtons(title: "Birthday", icon: "birthday.cake")
                createThemeButtons(title: "Earth", icon: "leaf")
                createThemeButtons(title: "New Years", icon: "fireworks")
                createThemeButtons(title: "Internet", icon: "globe")
                createThemeButtons(title: "Food", icon: "takeoutbag.and.cup.and.straw")
                createThemeButtons(title: "Space", icon: "sun.max.circle")
            }
        }.scrollIndicators(.hidden)
    }
    
    var cards: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 75), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) { card in
                    CardView(card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }.animation(.default, value: viewModel.cards)
            }
        }.scrollIndicators(.hidden)
    }
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
                    .fill(.white)
                    .strokeBorder(lineWidth: 2)
                    .foregroundStyle(.orange)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }.opacity(card.isFaceUp ? 1 : 0)
        }.opacity(card.isMatched ? 0 : 1)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
