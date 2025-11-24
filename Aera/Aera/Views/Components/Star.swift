//
//  Star.swift
//  Aera
//
//  Created by 권예원 on 11/24/25.
//

import SwiftUI

struct RatingSummaryView: View {
    let rating: Double
    let reviewCount: Int
        
    var body: some View {
        HStack(spacing: 6) {
            
            StarStaticView(rating: Int(rating.rounded()))
            
            Text(String(format: "%.1f", rating))
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("(\(reviewCount))")
                .font(.subheadline)
                .foregroundColor(.gray.opacity(0.7))
        }
    }
}

struct StarStaticView: View {
    let rating: Int
    
    var body: some View {
        HStack(spacing: 3) {
            ForEach(1...5, id: \.self) { i in
                Image(i <= rating ? "icon_star_fill" : "icon_star_empty")
                    .resizable()
                    .frame(width: 12, height: 12)
            }
        }
    }
}
