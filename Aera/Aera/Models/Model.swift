//
//  Model.swift
//  Aera
//
//  Created by 권예원 on 11/21/25.
//

import Foundation


struct Product: Identifiable {
    let id: Int
    let imageURL: String
    let name: String
    let brand: String
    
    // let price: Int
    // let volume: String
    
    let description: String
    let rating: Double          // avgScore
    let reviewCount: Int
    let notes: PerfumeNotes?           // top/middle/base notes
    let reviews: [Review]
}


extension Product {
    static let empty = Product(
        id: 0,
        imageURL: "",
        name: "",
        brand: "",
        // price: 0,
        // volume: "",
        description: "",
        rating: 0,
        reviewCount: 0,
        notes: nil,
        reviews: []
    )
}



struct PerfumeNotes {
    let top: [String]
    let middle: [String]
    let base: [String]
}


struct Review: Identifiable {
    let id: Int
    
    // let productID: Int
    
    let userID: Int
    let userNameMasked: String
    let rating: Int            
    let content: String
    let date: String
}


struct User {
    let name : String
    let email : String
}



