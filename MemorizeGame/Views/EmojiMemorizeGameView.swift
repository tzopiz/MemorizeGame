//
//  EmojiMemorizeGameView.swift
//  MemorizeGame
//
//  Created by Дмитрий Корчагин on 11/27/23.
//

import SwiftUI

struct EmojiMemorizeGameView: View {
    
    @ObservedObject var viewModel: EmojiMemorizeGame
    
    var body: some View {
        VStack() {
            cards
                .animation(.default, value: viewModel.cards)
            HStack(spacing: 32) {
                resetButton
                shuffleButton
            }
        }
        .padding(EdgeInsets(top: 0, leading: 4,  bottom: 0, trailing: 4))
    }
    
    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: 3/4) { card in
            CardView(card: card)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
    private var shuffleButton: some View {
        Button("shuffle") {
            self.viewModel.shuffle()
        }
        .blueRoundedStyle()
    }
    private var resetButton: some View {
        Button("reset") {
            self.viewModel.reset()
        }
        .blueRoundedStyle()
    }
}

#Preview {
    EmojiMemorizeGameView(viewModel: EmojiMemorizeGame())
}
