//
//  SplashView.swift
//  Aera
//
//  Created by 김미주 on 11/15/25.
//

import SwiftUI

struct SplashView: View {
    @Binding var isFinished: Bool
    
    @State private var bgColor: Color = .aricticLight
    @State private var isStarPhase = true
    @State private var isLightPhase: Bool = false
    
    @State private var offsetX: CGFloat = -158
    @State private var offsetY: CGFloat = 0
    
    @State private var starOpacity: Double = 0
    @State private var logoOpacity: Double = 0

    var body: some View {
        ZStack {
            bgColor
            
            if isStarPhase {
                Image(.logoStar)
                    .resizable()
                    .frame(width: 178, height: 77)
                    .opacity(starOpacity)
                    .offset(x: offsetX, y: offsetY)
            }
            
            if !isStarPhase || logoOpacity > 0 {
                Image(isLightPhase ? .logoLight : .logoDark)
                    .resizable()
                    .frame(width: 178, height: 77)
                    .opacity(logoOpacity)
                    .offset(x: offsetX, y: offsetY)
            }
        }
        .ignoresSafeArea()
        .onAppear { runAnimation() }
    }
    
    
    private func runAnimation() {
        
        // 배경 dark
        withAnimation(.easeInOut(duration: 0.7)) {
            bgColor = .midnightDark
        }
        
        // 별 등장
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            withAnimation(.easeOut(duration: 0.3)) {
                starOpacity = 1
            }
            
            // 별 이동
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeOut(duration: 0.6)) {
                    offsetX = 0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isLightPhase = true
                        logoOpacity = 1
                    }
                }
            }
        }
        
        // 로고 위로 이동
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut(duration: 0.8)) {
                offsetY = -300
            }
        }
        
        // 밝은 배경 + 밝은 로고
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
            withAnimation(.easeInOut(duration: 0.4)) {
                isLightPhase = false
                bgColor = .aricticLight
            }
        }
        
        // 종료
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            withAnimation {
                isFinished = true
            }
        }
    }
}


#Preview {
    SplashView(isFinished: .constant(false))
}
