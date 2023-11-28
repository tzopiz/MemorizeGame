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
    
    @State
    fileprivate var lastScoreChange = (amount: 0, byCardID: UUID())
    
    var body: some View {
        VStack() {
            score
            cards
            HStack(spacing: 32) {
                resetButton
                shuffleButton
            }
        }
        .padding(EdgeInsets(top: 0, leading: 4,  bottom: 0, trailing: 4))
    }
    
    fileprivate var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: 3/4) { card in
            CardView(card: card)
                .overlay(FlyingNumber(number: scoreChange(by: card)))
                .zIndex(scoreChange(by: card) != 0 ? 100.0 : 0.0)
                .onTapGesture {
                    withAnimation { chooseCard(card) }
                }
        }
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
    fileprivate func scoreChange(by card: Card) -> Int {
        return card.id == lastScoreChange.byCardID ? lastScoreChange.amount : 0
    }
    fileprivate func chooseCard(_ card: Card) {
        let scoreBeforeChoosing = viewModel.score
        viewModel.choose(card)
        let scoreChange = viewModel.score - scoreBeforeChoosing
        lastScoreChange = (scoreChange, card.id)
    }
    
}

#Preview {
    EmojiMemorizeGameView(viewModel: EmojiMemorizeGame())
}
