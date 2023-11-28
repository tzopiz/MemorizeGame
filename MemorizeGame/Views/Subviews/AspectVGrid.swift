//
//  AspectVGrid.swift
//  MemorizeGame
//
//  Created by Дмитрий Корчагин on 11/27/23.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    
    var items: [Item]
    var aspectRatio: CGFloat = 1.0
    var content: (Item) -> ItemView
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                aspectRatio: aspectRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)],
                      spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .padding(4)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    fileprivate func gridItemWidthThatFits(
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
}
