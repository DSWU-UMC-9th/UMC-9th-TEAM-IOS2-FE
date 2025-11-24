//
//  MockData.swift
//  Aera
//
//  Created by 권예원 on 11/23/25.
//

import Foundation

struct MockUser {
    static let current = User(
        id: 101,
        name: "UMCCCCMU"
    )
}

struct MockProducts {
    static let all: [Product] = [
        Product(
            id: 1,
            imageURL: "img_bottari",
            name: "퍼퓸 보타리",
            brand: "TAMBURINS",
            price: 178000,
            volume: "50ML",
            description: "보타리는 버섯 포자가 터질 때 느껴지는 폭발적인 생명력을 닮아, 깊고 감각적인 향의 파동으로 주변을 장악합니다. 단단한 매듭 속에 감춰진 것들이 하나씩 모습을 드러내며 호기심을 자아내고, 시원한 아키갈라우드를 가득 머금은 공기가 스치면 젖은 대지 위 부드러운 이끼와 나뭇결의 내음이 뒤따르며 예상치 못한 향의 변주가 시작됩니다.",
            rating: 4.5,
            alreadyReviewed: true,
            reviewCount: 3,
            reviews: [
                Review(
                    id: 1,
                    productID: 1,
                    userID: 101,
                    userNameMasked: "UMCC****",
                    rating: 4,
                    content: "생각보다 향이 너무 은은해요. 제 취향은 아니었어요. 지속력도 보통입니다.",
                    date: "2025.11.14"
                ),
                Review(
                    id: 2,
                    productID: 1,
                    userID: 200,
                    userNameMasked: "Perf****",
                    rating: 5,
                    content: "선물용으로 샀는데 다들 좋아하네요!",
                    date: "2025.11.13"
                ),
                Review(
                    id: 3,
                    productID: 1,
                    userID: 300,
                    userNameMasked: "SWEET***",
                    rating: 4,
                    content: "숲 느낌이 좋아요. 지속력은 보통!",
                    date: "2025.11.12"
                )
            ]
        ),


        Product(
            id: 2,
            imageURL: "img_blanche",
            name: "블랑쉬 오드퍼퓸",
            brand: "BYREDO",
            price: 239000,
            volume: "50ML",
            description: "깨끗하고 투명한 비누향...",
            rating: 4.2,
            alreadyReviewed: true,
            reviewCount: 2,
            reviews: [
                Review(
                    id: 4,
                    productID: 2,
                    userID: 101,
                    userNameMasked: "UMCC****",
                    rating: 3,
                    content: "선물용으로 샀는데 받는 분이 정말 만족하셨어요. 향이 은은하고 고급스럽다고 하네요.",
                    date: "2025.11.11"
                ),
                Review(
                    id: 5,
                    productID: 2,
                    userID: 201,
                    userNameMasked: "USER****",
                    rating: 5,
                    content: "완전 내 취향! 답답함 없는 비누향 최고",
                    date: "2025.11.09"
                )
            ]
        ),


        Product(
            id: 3,
            imageURL: "img_another13",
            name: "어나더 13",
            brand: "LE LABO",
            price: 280000,
            volume: "50ML",
            description: "이끼와 머스크의 중독적인 향...",
            rating: 4.8,
            alreadyReviewed: false,
            reviewCount: 1,
            reviews: [
                Review(
                    id: 6,
                    productID: 3,
                    userID: 500,
                    userNameMasked: "HANJ***",
                    rating: 5,
                    content: "중성적이고 중독적인 향. 유니크함 최고!",
                    date: "2025.11.05"
                )
            ]
        )
    ]
}
