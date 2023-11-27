//
//  EmojiMemorizeGame.swift
//  MemorizeGame
//
//  Created by Дмитрий Корчагин on 11/27/23.
//

import Foundation

class EmojiMemorizeGame: ObservableObject {
    private static let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🐼",
                                 "🧙🏼‍♀️", "🙀", "👺", "🍬", "👹", "😱",
                                 "☠️", "🧌", "🫠", "👽", "🤡", "🤖",
                                 "🧜‍♂️", "🧚‍♀️", "🧛🏻‍♂️", "🥷🏿", "🐹", "⛄️"]
    @Published private var model = MemorizeGameModel<String>(numberOfPairsOfCard: 24) { index in
    
        guard emojis.indices.contains(index) else { return "💩" }
        return emojis[index]
    }
    
    var cards: Array<CardView.Card> {
        return model.cards
    }
    var score: Int {
        return model.score
    }
    
    // MARK: - Intents
    
    func reset() {
        model.reset()
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: CardView.Card) {
        model.choose(card)
    }
}
