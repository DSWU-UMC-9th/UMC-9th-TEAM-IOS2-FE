//
//  Header.swift
//  Aera
//
//  Created by 김미주 on 11/15/25.
//

import SwiftUI

struct Header: View {
    var onTapMyPage: () -> Void
    var onTapLogo: () -> Void = {}

    var body: some View {
        HStack {
            Button(action: { onTapLogo() }) {
                Image(.logoHeader)
            }

            Spacer()

            myPageButton
        }
        .padding(.top, 44)
        .padding(.horizontal, 24)
        .padding(.vertical, 13)
    }
    
    var myPageButton: some View {
        Button(action: { onTapMyPage() }) {
            Image(.imgUser)
        }
    }
}

#Preview {
    Header(
        onTapMyPage: { print("goToMypage") },
        onTapLogo: { print("goToMain") }
    )
}
