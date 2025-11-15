//
//  MainView.swift
//  Aera
//
//  Created by 김미주 on 11/15/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            Color.aricticLight

            ScrollView {
                Header()

                Text("MainView")
                    .font(.XxlMedium)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MainView()
}
