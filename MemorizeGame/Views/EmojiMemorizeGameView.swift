//
//  EmojiMemorizeGameView.swift
//  MemorizeGame
//
//  Created by Дмитрий Корчагин on 11/27/23.
//

import SwiftUI

struct EmojiMemorizeGameView: View {
    @ObservedObject var viewModel: EmojiMemorizeGame
    
    private let aspectRatio: CGFloat = 2/3
    
    private var cards: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: viewModel.cards.count,
                size: geometry.size,
                aspectRatio: aspectRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)],
                      spacing: 0) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            print(gridItemSize)
                            viewModel.choose(card)
                        }
                }
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
    private func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        aspectRatio: CGFloat
    ) -> CGFloat {
            let count = CGFloat(count)
            var columnCount = 1.0
            repeat {
                let width = size.width / columnCount
                let height = width / aspectRatio
    
                let rowCount = (count / columnCount).rounded(.up)
                if rowCount * height < size.height {
                    return (size.width / columnCount).rounded(.down)
                }
                columnCount += 1
            } while columnCount < count
            return min(size.width / count, size.height * aspectRatio).rounded(.down)
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
