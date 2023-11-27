//
//  MemorizeGame.swift
//  MemorizeGameModel
//
//  Created by Дмитрий Корчагин on 11/27/23.
//

import Foundation

struct MemorizeGameModel<Content: Equatable> {
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        let id: UUID = UUID()
        var isFaceUp: Bool = false {
            didSet {
                if oldValue, !isFaceUp { hasBeenSeen = true }
            }
        }
        var hasBeenSeen: Bool = false
        var isMatched: Bool = false
        let content: Content
        var debugDescription: String {
            """
            \nid: \(id)
            isMatched: \(isMatched)
            content: \(content)
            """
        }
        
    }
    
    private(set) var cards: Array<Card>
    private(set) var score: Int = 0
    
    var indexOfFacedUpCard: Int? {
        get {
            let indices = cards.indices.filter { cards[$0].isFaceUp && !cards[$0].isMatched }
            return indices.count == 1 ? indices.first : nil
        }
        set {
            for index in cards.indices where !cards[index].isMatched {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    init(numberOfPairsOfCard: Int, _ content: @escaping (Int) -> Content) {
        self.cards = []
        for index in 0..<max(2, numberOfPairsOfCard) {
            let card1 = Card(content: content(index))
            let card2 = Card(content: content(index))
            self.cards += [card1, card2]
        }
    }
    mutating func reset() {
        cards.indices.forEach {
            cards[$0].isMatched = false
            cards[$0].isFaceUp = false
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }

    mutating func choose(_ card: Card) {
        guard let indexOfCurrentCard = cards.firstIndex(where: { $0 == card }) else { return }
        if !cards[indexOfCurrentCard].isFaceUp, !cards[indexOfCurrentCard].isMatched {
            if let indexOfFacedUpCard = indexOfFacedUpCard {
                if cards[indexOfCurrentCard].content == cards[indexOfFacedUpCard].content {
                    cards[indexOfCurrentCard].isMatched = true
                    cards[indexOfFacedUpCard].isMatched = true
                    score += 2
                } else {
                    if cards[indexOfCurrentCard].hasBeenSeen { score -= 1 }
                    if cards[indexOfFacedUpCard].hasBeenSeen { score -= 1 }
                }
            } else {
                indexOfFacedUpCard = indexOfCurrentCard
            }
            cards[indexOfCurrentCard].isFaceUp = true
        }
    }
}
