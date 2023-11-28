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
        TimelineView(.animation) { timeline in
            Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                .opacity(0.33)
                .padding(2)
                .overlay(text)
                .cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched)
        }
    }
    fileprivate var text: some View {
        Text(card.content)
            .font(.system(size: 200))
            .multilineTextAlignment(.center)
            .minimumScaleFactor(0.1)
            .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    let cards = [CardView.Card(content: "-"),
                 CardView.Card(isFaceUp: true, content: "🧞"),
                 CardView.Card(isFaceUp: true, isMatched: true, content: "🧞‍♀️"),
                 CardView.Card(isFaceUp: true, isMatched: false, content: "🧞‍♂️")]
    return AspectVGrid(cards, aspectRatio: 3/4) { card in
        CardView(card: card)
            .padding(EdgeInsets(top: 0, leading: 4,  bottom: 0, trailing: 4))
    }
}
