//
//  FlyingNumber.swift
//  MemorizeGame
//
//  Created by Дмитрий Корчагин on 11/28/23.
//

import SwiftUI

struct FlyingNumber: View {
    
    @State
    fileprivate var offset: CGFloat = 0
    
    var number: Int
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number.sign(strategy: .always()))
                .font(.largeTitle)
                .foregroundStyle(number < 0 ? Color.red : Color.green)
                .shadow(color: .black, radius: 2, x: 1, y: 1)
                .offset(x: 0, y: offset)
                .opacity(offset == 0 ? 1 : 0)
                .onAppear {
                    withAnimation(.easeIn(duration: 1)) {
                        offset = number < 0 ? 100 : -100
                    }
                }
                .onDisappear { offset = 0 }
        }
    }
}
