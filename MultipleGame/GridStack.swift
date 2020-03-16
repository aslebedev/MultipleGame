//
//  GridStack.swift
//  MultipleGame
//
//  Created by alexander on 10.03.2020.
//  Copyright © 2020 alexander. All rights reserved.
//

import SwiftUI

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack (spacing: 11) {
            Text("Up to which do you want to practice?")
            
            ForEach(0 ..< rows) { row in
                HStack {
                    ForEach(0 ..< self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}
