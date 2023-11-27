//
//  MemorizeGame.swift
//  MemorizeGame
//
//  Created by Дмитрий Корчагин on 11/27/23.
//

import Foundation

struct MemorizeGame<Content: Equatable> {
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        let id: UUID = UUID()
        var isFaceUP: Bool = false
        var isMatched: Bool = false
        let content: Content
        var debugDescription: String {
            """
            \nid: \(id)\nisFaceUp: \(isFaceUP)
            isMatched: \(isMatched)\ncontent: \(content)
            """
        }
        
    }
    var indexOfFacedUpCard: Int? {
        get {
            let indices = cards.indices.filter { cards[$0].isFaceUP && !cards[$0].isMatched }
            return indices.count == 1 ? indices.first : nil
        }
        set {
            for index in cards.indices where !cards[index].isMatched {
                cards[index].isFaceUP = index == newValue
            }
        }
    }
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCard: Int, _ content: @escaping (Int) -> Content) {
        self.cards = []
        for index in 0..<max(2, numberOfPairsOfCard) {
            let card1 = Card(content: content(index))
            let card2 = Card(content: content(index))
            self.cards += [card1, card2]
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }

    mutating func choose(_ card: Card) {
        guard let indexOfCurrentCard = cards.firstIndex(where: { $0 == card }) else { return }
        if !cards[indexOfCurrentCard].isFaceUP, !cards[indexOfCurrentCard].isMatched {
            if let indexOfFacedUpCard = indexOfFacedUpCard {
                if cards[indexOfCurrentCard].content == cards[indexOfFacedUpCard].content {
                    cards[indexOfCurrentCard].isMatched = true
                    cards[indexOfFacedUpCard].isMatched = true
                }
            } else {
                indexOfFacedUpCard = indexOfCurrentCard
            }
            cards[indexOfCurrentCard].isFaceUP = true
        }
    }
}
