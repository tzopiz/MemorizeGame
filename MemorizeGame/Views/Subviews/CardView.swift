//
//  CardView.swift
//  MemorizeGame
//
//  Created by Дмитрий Корчагин on 11/27/23.
//

import SwiftUI

struct CardView: View {
    
    typealias Card = MemorizeGameModel<String>.Card
    
    let card: Card
    
    var body: some View {
        Pie(endAngle: .degrees(360))
            .opacity(0.33)
            .overlay(
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.1)
                    .aspectRatio(1, contentMode: .fit)
            )
            .cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched)
    }
}

#Preview {
    let cards = [CardView.Card(content: "🤖"),
                 CardView.Card(isFaceUp: true, content: "🤖"),
                 CardView.Card(isFaceUp: true, isMatched: true, content: "🤖"),
                 CardView.Card(isFaceUp: true, isMatched: false, content: "🤖")]
    return AspectVGrid(items: cards, aspectRatio: 3/4) { card in
        CardView(card: card)
            .padding(EdgeInsets(top: 0, leading: 4,  bottom: 0, trailing: 4))
    }
}
