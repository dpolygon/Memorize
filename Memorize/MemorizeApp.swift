//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Daniel Gonzalez on 7/17/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
