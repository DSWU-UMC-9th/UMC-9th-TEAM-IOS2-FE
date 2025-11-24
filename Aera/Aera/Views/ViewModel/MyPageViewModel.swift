//
//  MyPageViewModel.swift
//  Aera
//
//  Created by 권예원 on 11/24/25.
//

import SwiftUI
import Combine


class MyPageViewModel:ObservableObject {
    @Published var myReviews: [Review] = []
    @Published var sortOption: SortOption = .latest {
        didSet { sortReviews() }
    }
    
    let currentUser = MockUser.current
    let products = MockProducts.all

    enum SortOption {
        case latest
        case oldest
    }

    init() {
        loadReviews()
        sortReviews()
    }
    
    // 해당 유저 리뷰만 필터링
    func loadReviews() {
        myReviews = products
            .flatMap { $0.reviews }
            .filter { $0.userID == currentUser.id }
    }
    
    // 최신순, 오래된 순
    func sortReviews() {
        switch sortOption {
        case .latest:
            myReviews.sort { $0.date > $1.date }
        case .oldest:
            myReviews.sort { $0.date < $1.date }
        }
    }
    
    // 해당 프로덕트 연결
    func product(for review: Review) -> Product? {
        products.first(where: { $0.id == review.productID })
    }

}
