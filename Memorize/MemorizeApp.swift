//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Daniel Gonzalez on 7/17/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = MemoryGame()
    
    var body: some Scene {
        WindowGroup {
            MemoryGameView(viewModel: game)
        }
    }
}
