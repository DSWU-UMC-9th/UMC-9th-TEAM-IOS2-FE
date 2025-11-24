//
//  DetailViewModel.swift
//  Aera
//
//  Created by 권예원 on 11/21/25.
//

import SwiftUI

struct Product: Identifiable {
    let id : Int
    let imageURL : String
    let name : String
    let brand : String
    let price : Int
    let volume : String
    let description : String
    
    let rating : Double

    let alreadyReviewed: Bool
    let reviewCount: Int
    let reviews:[Review]
}

extension Product {
    static let empty = Product(
        id: 0,
        imageURL: "",
        name: "",
        brand: "",
        price: 0,
        volume: "",
        description: "",
        rating: 0,
        alreadyReviewed: false,
        reviewCount: 0,
        reviews: []
    )
}


struct Review: Identifiable {
    let id: Int
    let productID: Int
    let userID: Int
    let userNameMasked: String
    let rating: Int
    let content: String
    let date: String
}

struct User {
    let id: Int
    let name: String
    var maskedName: String {
        NameMasker.mask(name)
    }
}

struct NameMasker {
    static func mask(_ name: String) -> String {
        let count = name.count

        guard count > 1 else { return "*" }

        if count == 2 {
            return "\(name.prefix(1))*"
        }

        let prefix = name.prefix(2)
        let mask = String(repeating: "*", count: count - 2)
        return "\(prefix)\(mask)"
    }
}
