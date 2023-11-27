//
//  MemorizeGame.swift
//  MemorizeGame
//
//  Created by Дмитрий Корчагин on 11/27/23.
//

import Foundation

struct MemorizeGame<Content> {
    struct Card {
        var isFaceUP: Bool = true
        var isMatched: Bool = false
        let content: Content
    }
    
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCard: Int, _ content: @escaping (Int) -> Content) {
        self.cards = []
        for index in 0..<max(2, numberOfPairsOfCard) {
            let card = Card(content: content(index))
            self.cards += [card, card]
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    func choose(_ card: Card) { }
}
