//
//  DetailViewModel.swift
//  Aera
//
//  Created by 권예원 on 11/21/25.
//

import SwiftUI
import Combine


class DetailViewModel: ObservableObject {
    @Published var product: Product = .empty

    @Published var isLoading = false
    
    @Published var newReviewRating: Int = 0
    @Published var reviewText: String = ""
    @Published var showReviewPopup: Bool = false
    
    let currentUser = MockUser.current
    
    private var tempReviewID = 9999 // 임시
    
    init() {
        fetchProduct()
    }

    func fetchProduct() {
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.product = MockProducts.all.first!
            self.isLoading = false
        }
    }

    // 이 사용자가 이미 리뷰를 썼는지 여부 - UI
    var hasUserReviewed: Bool {
        product.reviews.contains { $0.userID == currentUser.id }
    }
    
    // 리뷰 등록 가능 여부
    var canSubmitReview: Bool {
        !hasUserReviewed &&
        !reviewText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        newReviewRating > 0
    }
    
    // 추후 POST 요청으로 바꿀 예정
    func submitReview() {
        guard canSubmitReview else { return }
            
//        // 새로운 리뷰 생성
//        let newReview = Review(
//            id: tempReviewID,
//            userID: currentUser.id,
//            userNameMasked: currentUser.maskedName,
//            rating: newReviewRating,
//            content: reviewText,
//            date: formattedToday()
//        )
//
//        tempReviewID += 1
//
//        // 최신순으로 추가
//        var updatedReviews = product.reviews
//        updatedReviews.insert(newReview, at: 0)
//
//        // updatedProduct 생성
//        let updatedProduct = Product(
//            id: product.id,
//            imageURL: product.imageURL,
//            name: product.name,
//            brand: product.brand,
//            price: product.price,
//            volume: product.volume,
//            description: product.description,
//            rating: product.rating,
//            alreadyReviewed: true,
//            reviewCount: product.reviewCount + 1,
//            reviews: updatedReviews
//        )
//
//        // 상태 업데이트
//        self.product = updatedProduct
        
        showReviewPopup = true
        
        // 입력 초기화
        reviewText = ""
        newReviewRating = 0
    }
    
    // Fommater
    var priceText: String {
        return "\(product.price.formatted())"
    }
    
    private func formattedToday() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: Date())
    }
}
