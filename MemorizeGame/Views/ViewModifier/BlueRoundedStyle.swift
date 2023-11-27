//
//  BlueRoundedStyle.swift
//  MemorizeGame
//
//  Created by Дмитрий Корчагин on 11/27/23.
//

import SwiftUI

struct BlueRoundedStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding([.horizontal], 16)
            .padding([.vertical], 4)
            .font(.title)
            .foregroundStyle(Color.white)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 6), style: FillStyle())
    }
}
