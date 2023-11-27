//
//  EmojiMemorizeGame.swift
//  MemorizeGame
//
//  Created by Дмитрий Корчагин on 11/27/23.
//

import Foundation

class EmojiMemorizeGame: ObservableObject {
    private static let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙🏼‍♀️", "🙀", "👺", "🍬", "👹", "😱", "☠️", "🧌"]
    @Published private var model = MemorizeGame<String>(numberOfPairsOfCard: 8) { index in
    
        guard emojis.indices.contains(index) else { return "💩" }
        return emojis[index]
    }
    
    var cards: Array<MemorizeGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func reset() {
        model.reset()
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemorizeGame<String>.Card) {
        model.choose(card)
    }
}
