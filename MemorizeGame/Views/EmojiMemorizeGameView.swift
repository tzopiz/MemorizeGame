//
//  EmojiMemorizeGameView.swift
//  MemorizeGame
//
//  Created by Дмитрий Корчагин on 11/27/23.
//

import SwiftUI

struct EmojiMemorizeGameView: View {
    
    @ObservedObject var viewModel: EmojiMemorizeGame
    
    private var cards: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: 3/4) { card in
            CardView(card: card)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundStyle(Color.orange)
    }
    private var shuffleButton: some View {
        Button("shuffle") {
            self.viewModel.shuffle()
        }
        .modifier(BlueRoundedStyle())
    }
    private var resetButton: some View {
        Button("reset") {
            self.viewModel.reset()
        }
        .modifier(BlueRoundedStyle())
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            cards
                .animation(.default, value: viewModel.cards)
            HStack(spacing: 32) {
                resetButton
                shuffleButton
            }
        }
        .padding(EdgeInsets(top: 0, leading: 4,  bottom: 0, trailing: 4))
    }
}

#Preview {
    EmojiMemorizeGameView(viewModel: EmojiMemorizeGame())
}
