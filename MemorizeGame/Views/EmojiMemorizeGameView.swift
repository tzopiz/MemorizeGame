//
//  EmojiMemorizeGameView.swift
//  MemorizeGame
//
//  Created by Дмитрий Корчагин on 11/27/23.
//

import SwiftUI

struct EmojiMemorizeGameView: View {
    typealias Card = CardView.Card
    
    @ObservedObject
    var viewModel: EmojiMemorizeGame
    
    @Namespace
    fileprivate var dealing
    
    @State
    fileprivate var lastScoreChange = (amount: 0, byCardID: UUID())
    @State
    fileprivate var dealt = Set<Card.ID>()
    
    fileprivate let aspectRatio: CGFloat = 3/4
    fileprivate let dealAnimation: Animation = .easeInOut(duration: 1)
    fileprivate let dealInterval: TimeInterval = 0.15
    fileprivate let deckWidth: CGFloat = 75
    
    fileprivate var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    // MARK: - body
    
    var body: some View {
        ZStack {
            deck
            VStack {
                score
                cards
                HStack(spacing: 32) {
                    resetButton
                    shuffleButton
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 4,  bottom: 0, trailing: 4))
    }
    
    // MARK: - Views
    
    fileprivate var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                cardview(for: card)
                    .overlay(FlyingNumber(number: scoreChange(by: card)))
                    .zIndex(scoreChange(by: card) != 0 ? 100 : 0)
                    .onTapGesture { choose(card)  }
            }
        }
    }
    fileprivate var deck: some View {
        ZStack {
            ForEach(undealtCards) { cardview(for: $0) }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onAppear { deal() }
    }
    
    fileprivate var shuffleButton: some View {
        Button("shuffle") {
            withAnimation(.interactiveSpring(response: 0.75,
                                             dampingFraction: 0.5)) {
                self.viewModel.shuffle()
            }
        }
        .blueRoundedStyle()
    }
    fileprivate var resetButton: some View {
        Button("reset") {
            withAnimation {
                self.viewModel.reset()
            }
        }
        .blueRoundedStyle()
    }
    
    fileprivate var score: some View {
        HStack {
            Spacer()
            Text("Best: \(viewModel.record)")
                .animation(nil) // permanent change score
            Spacer()
            Text("Score: \(viewModel.score)")
                .animation(nil) // make animation scrolling
            Spacer()
        }
        .font(.title2)
    }
    
    // MARK: - funcs
    
    fileprivate func cardview(for card: Card) -> some View {
        CardView(card: card)
            .matchedGeometryEffect(id: card.id, in: dealing)
            .transition(.asymmetric(insertion: .identity, removal: .identity))
    }
    fileprivate func scoreChange(by card: Card) -> Int {
        return card.id == lastScoreChange.byCardID ? lastScoreChange.amount : 0
    }
    fileprivate func choose(_ card: Card) {
        let scoreBeforeChoosing = viewModel.score
        viewModel.choose(card)
        let scoreChange = viewModel.score - scoreBeforeChoosing
        lastScoreChange = (scoreChange, card.id)
    }
    fileprivate func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    fileprivate func deal() {
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(dealAnimation.delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += dealInterval
        }
    }
}

#Preview {
    EmojiMemorizeGameView(viewModel: EmojiMemorizeGame())
}
