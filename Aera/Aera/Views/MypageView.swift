//
//  MypageView.swift
//  Aera
//
//  Created by 김미주 on 11/15/25.
//

import SwiftUI

struct MypageView: View {
    var body: some View {
        ZStack {
            Color.aricticLight

            ScrollView {
                Header()

                Text("MypageView")
                    .font(.XxlMedium)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MypageView()
}
