//
//  Card.swift
//  MemorizeGame
//
//  Created by Дмитрий Корчагин on 11/28/23.
//

import Foundation

extension MemorizeGameModel {
    struct GameRecord {
        static fileprivate var userDefaultsKey: String { "gameRecord" }
        
        static func saveRecord(_ newRecord: Int) {
            let userDefaults = UserDefaults.standard
            let currentRecord = userDefaults.integer(forKey: userDefaultsKey)
            
            if newRecord > currentRecord {
                userDefaults.set(newRecord, forKey: userDefaultsKey)
            }
        }
        
        static func loadRecord() -> Int {
            let userDefaults = UserDefaults.standard
            let currentRecord = userDefaults.integer(forKey: userDefaultsKey)
            return currentRecord
        }
    }
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        let id: UUID = UUID()
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp { startUsingBonusTime() }
                else { stopUsingBonusTime() }
                if oldValue, !isFaceUp { hasBeenSeen = true }
            }
        }
        var hasBeenSeen: Bool = false
        var isMatched: Bool = false {
            didSet {
                if isMatched { stopUsingBonusTime() }
            }
        }
        let content: Content
        
        // MARK: - Bonus Time
        /// Call this when the card transitions to face up state
        private mutating func startUsingBonusTime () {
            if isFaceUp, !isMatched, bonusPercentRemaining > 0, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        /// Call this when the card goes back face down or gets matched
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        /// The bonus earned so far (one point for every second of the bonusTimeLimit that was not used)
        /// This gets smaller and smaller the longer the card remains face up without being matched
        var bonus: Int {
            Int(bonusTimeLimit * bonusPercentRemaining)
        }
        /// Percentage of the bonus time remaining
        var bonusPercentRemaining: Double {
            bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime) / bonusTimeLimit : 0
        }
        /// How long this card has ever been face up and unmatched during its lifetime.
        /// Basically, `pastFaceUpTime` + time since `lastFaceUpDate`
        var faceUpTime: TimeInterval {
            if let lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else { return pastFaceUpTime }
        }
        /// Can be zero which would mean "no bouns available" for matching card quicly
        var bonusTimeLimit: TimeInterval = 6
        /// The last time this card was turned face up
        var lastFaceUpDate: Date?
        /// The accumulated time this card was face up in the past.
        /// (i.e. not including the current time its been face up if its currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // MARK: - CustomDebugStringConvertible
        
        var debugDescription: String {
            """
            \nid: \(id)
            isMatched: \(isMatched)
            content: \(content)
            """
        }
    }
}
