//
//  Cardify.swift
//  MemorizeGame
//
//  Created by Дмитрий Корчагин on 11/27/23.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    
    var isMatched: Bool
    var rotation: CGFloat
    
    var isFaceUp: Bool {
        rotation < 90
    }
    var animatableData: CGFloat {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool, isMatched: Bool) {
        rotation = isFaceUp ? 0 : 180
        self.isMatched = isMatched
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            base.strokeBorder(lineWidth: 3)
                .background(base.fill(isMatched ? Color.gray.opacity(0.3) : Color.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            base.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .shadow(radius: 3)
        .disabled(isMatched || isFaceUp)
        .foregroundStyle(isMatched ? Color.gray : Color.blue)
        .rotation3DEffect(.degrees(rotation), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
}

extension View {
    func cardify(isFaceUp: Bool, isMatched: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp, isMatched: isMatched))
    }
}
