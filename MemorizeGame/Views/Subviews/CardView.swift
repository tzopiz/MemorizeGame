//
//  CardView.swift
//  MemorizeGame
//
//  Created by Дмитрий Корчагин on 11/27/23.
//

import SwiftUI

struct CardView: View {
    let card: MemorizeGame<String>.Card
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.background)
                base.strokeBorder(lineWidth: 3)
                Text(card.content)
                    .font(.system(size: 100))
                    .minimumScaleFactor(0.5)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUP ? 1 : 0)
            base
                .fill()
                .opacity(card.isFaceUP ? 0 : 1)
        }
        .disabled(card.isMatched || card.isFaceUP)
        .foregroundStyle(card.isMatched ? Color.gray : Color.orange)
    }
}
