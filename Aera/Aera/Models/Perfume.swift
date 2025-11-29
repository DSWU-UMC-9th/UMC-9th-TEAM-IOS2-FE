//
//  Perfume.swift
//  Aera
//
//  Created by Jung Hyun Han on 11/27/25.
//

import Foundation

struct PerfumeResponse: Codable {
    let recommendedPerfumes: [Perfume]
    let perfumes: [Perfume]
}

struct Perfume: Codable, Identifiable {
    let id: Int
    let name: String
    let brand: String
    let imageUrl: String
    let avgScore: Double
    let reviewCount: Int
}
