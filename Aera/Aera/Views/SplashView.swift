//
//  SplashView.swift
//  Aera
//
//  Created by 김미주 on 11/15/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.aricticLight

            Text("SplashView")
                .font(.XxlMedium)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
