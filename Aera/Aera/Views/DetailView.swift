//
//  DetailView.swift
//  Aera
//
//  Created by 김미주 on 11/15/25.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        ZStack {
            Color.aricticLight

            ScrollView {
                Header()

                Text("DetailView")
                    .font(.XxlMedium)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    DetailView()
}
