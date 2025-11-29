//
//  InputView.swift
//  Aera
//
//  Created by 정서영 on 11/18/25.
//

import SwiftUI

struct InputView<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .foregroundStyle(.white)
                )
    }
}
