//
//  MemorizeGame.swift
//  MemorizeGameModel
//
//  Created by Дмитрий Корчагин on 11/27/23.
//

import Foundation

struct MemorizeGameModel<Content: Equatable> {
    
    fileprivate(set) var cards: Array<Card>
    fileprivate(set) var score: Int = 0 {
        willSet {
            if newValue > record { GameRecord.saveRecord(newValue) }
        }
    }
    var record: Int { GameRecord.loadRecord() }
    
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
    
    init(numberOfPairsOfCards: Int, _ content: @escaping (Int) -> Content) {
        cards = []
        for index in 0..<max(2, numberOfPairsOfCards) {
            let content = content(index)
            self.cards += [Card(content: content), Card(content: content)]
        }
    }
    mutating func reset() {
        cards.indices.forEach {
            cards[$0].isMatched = false
            cards[$0].isFaceUp = false
        }
        score = 0
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }

    mutating func choose(_ card: Card) {
        guard let indexOfCurrentCard = cards.firstIndex(where: { $0 == card }) 
        else { return }
        if !cards[indexOfCurrentCard].isFaceUp, !cards[indexOfCurrentCard].isMatched {
            if let indexOfFacedUpCard = indexOfFacedUpCard {
                if cards[indexOfCurrentCard].content == cards[indexOfFacedUpCard].content {
                    cards[indexOfCurrentCard].isMatched = true
                    cards[indexOfFacedUpCard].isMatched = true
                    score += 2 + cards[indexOfFacedUpCard].bonus + cards[indexOfCurrentCard].bonus
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
