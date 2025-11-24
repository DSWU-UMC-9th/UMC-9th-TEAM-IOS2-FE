//
//  AeraApp.swift
//  Aera
//
//  Created by 김미주 on 11/15/25.
//

import SwiftUI

@main
struct AeraApp: App {
    @State private var isSplashFinished = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isSplashFinished {
                    LoginView()
                        .transition(.opacity)
                } else {
                    SplashView(isFinished: $isSplashFinished)
                        .transition(.opacity)
                }
            }
        }
    }
}
