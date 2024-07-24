//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Daniel Gonzalez on 7/17/24.
//  Synonymous with the UI

import SwiftUI

struct MemoryGameView: View {
    @ObservedObject var viewModel: MemoryGame

    var body: some View {
        VStack {
            gameOverview
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
            viewModel.newTheme(with: title)
        } label: {
            VStack {
                Image(systemName: icon).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text(title).font(.caption)
            }
        }
            .padding(.leading)
            .disabled(viewModel.currentTheme == title)
    }
    
    var gameOverview: some View {
        HStack {
            score.padding(.leading)
            Spacer()
        }
    }
    
    var score: some View {
        Text(String(format: "%02d", viewModel.score))
            .font(.largeTitle)
            .fontWeight(.bold)
            .contentTransition(.numericText(value: Double(viewModel.score)))
            .fontDesign(.monospaced)
    }
    
    var themes: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .bottom) {
                ForEach(viewModel.getThemes()) { theme in
                    createThemeButtons(title: theme.name, icon: theme.symbol)
                }
            }
        }.scrollIndicators(.hidden)
    }
    
    var cards: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 75), spacing: 0)], spacing: 0) {
                ForEach(viewModel.cards) { card in
                    CardView(card, color: viewModel.getColor())
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            withAnimation {
                                viewModel.choose(card)
                            }
                        }
                }.animation(.default, value: viewModel.cards)
            }
        }.scrollIndicators(.hidden)
    }
}

struct CardView: View {
    let card: MemoryGameModel<String>.Card
    let themeColor: Color
    
    init(_ card: MemoryGameModel<String>.Card, color: Color) {
        self.card = card
        self.themeColor = color
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundStyle(themeColor)
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
    MemoryGameView(viewModel: MemoryGame())
}
