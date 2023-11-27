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
            HStack(spacing: 32) {
                resetButton
                shuffleButton
                Text("Score: \(viewModel.score)")
                    .animation(nil)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 4,  bottom: 0, trailing: 4))
    }
    
    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: 3/4) { card in
            CardView(card: card)
                .onTapGesture {
                    withAnimation {
                        viewModel.choose(card)
                    }
                }
        }
    }
    private var shuffleButton: some View {
        Button("shuffle") {
            withAnimation(.interactiveSpring(response: 0.75,
                                             dampingFraction: 0.5)) {
                self.viewModel.shuffle()
            }
        }
        .blueRoundedStyle()
    }
    private var resetButton: some View {
        Button("reset") {
            withAnimation {
                self.viewModel.reset()
            }
        }
        .blueRoundedStyle()
    }
}

#Preview {
    EmojiMemorizeGameView(viewModel: EmojiMemorizeGame())
}
