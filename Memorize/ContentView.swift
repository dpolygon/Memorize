//
//  ContentView.swift
//  Memorize
//
//  Created by Daniel Gonzalez on 7/17/24.
//

import SwiftUI

struct ContentView: View {
    let halloweenTheme = ["💀", "🎃", "👻", "😈", "👹", "🕷️", "🕸️", "👽", "🧛🏼‍♂️"]
    let birthdayTheme = ["😘", "🎉", "🎂", "🥳", "🎈", "🎊", "🎁", "🪅", "🍾", "👏🏼"]
    let christmasTheme = ["🎄", "🎅", "🇨🇽", "🤶", "🧑‍🎄", "❄️", "🌲", "☃️", "🗻", "🧤", "🧣"]
    @State var theme: [String]
    @State var currentTheme: String
    
    init() {
        theme = (halloweenTheme + halloweenTheme).shuffled()
        currentTheme = "Halloween"
    }
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            cards(with: theme)
            HStack {
                themeButtons
            }
        }.padding()
    }
    
    func cards(with emojis: [String]) -> some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                ForEach(0..<emojis.count, id: \.self) { index in
                    CardView(content: emojis[index], isFaceUp: false)
                        .aspectRatio(2/3, contentMode: .fit)
                }
            }
        }
    }
    
    func cardThemeButton(with Theme: [String], Symbol: String, Label: String) -> some View {
        Button {
            self.theme = (Theme + Theme).shuffled()
            self.currentTheme = Label
        } label: {
            VStack {
                Image(systemName: Symbol)
                    .imageScale(.large)
                    .font(.title)
                Text(Label)
                    .font(.caption)
            }
        }.disabled(currentTheme == Label)
    }
    
    var themeButtons: some View {
        HStack {
            cardThemeButton(with: birthdayTheme, Symbol: "sun.max.circle.fill", Label: "Birthday")
            cardThemeButton(with: christmasTheme, Symbol: "gift.circle.fill", Label: "Christmas")
            cardThemeButton(with: halloweenTheme, Symbol: "moon.dust.circle.fill", Label: "Halloween")
        }
    }
    
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
    let content: String
    @State var isFaceUp = true
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.orange)
                .opacity(isFaceUp ? 0 : 1)
            Group {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .strokeBorder(lineWidth: 2)
                    .foregroundStyle(.orange)
                Text(content)
            }.opacity(isFaceUp ? 1 : 0)
        }.onTapGesture {
            isFaceUp.toggle()
            print("Should face up: \(isFaceUp)")
        }
    }
}

#Preview {
    ContentView()
}
