//
//  Header.swift
//  Aera
//
//  Created by 김미주 on 11/15/25.
//

import SwiftUI

struct Header: View {
    var body: some View {
        // TODO: 네비게이션 버튼으로 연결
        HStack {
            Image(.logoHeader)

            Spacer()

            Image(.imgUser)
        }
        .padding(.top, 44)
        .padding(.horizontal, 24)
        .padding(.vertical, 13)
    }
}

#Preview {
    Header()
}
