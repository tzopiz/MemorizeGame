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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)],
                  spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card: card)
                    .aspectRatio(3/4, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
                  .foregroundStyle(Color.orange)
    }
    private var shuffleButton: some View {
        Button("shuffle") {
            self.viewModel.shuffle()
        }
        .padding([.horizontal], 16)
        .padding([.vertical], 4)
        .font(.title)
        .foregroundStyle(Color.white)
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 6), style: FillStyle())
    }
    private var resetButton: some View {
        Button("reset") {
            self.viewModel.reset()
        }
        .padding([.horizontal], 16)
        .padding([.vertical], 4)
        .font(.title)
        .foregroundStyle(Color.white)
        .background(Color.blue)
        .clipShape(RoundedRectangle(cornerRadius: 6), style: FillStyle())
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                cards
            }
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
