//
//  DetailViewModel.swift
//  Aera
//
//  Created by Jung Hyun Han on 11/30/25.
//

import Foundation
import Combine
import Moya

class DetailViewModel: ObservableObject {

    // 서버 값
    @Published var perfume: PerfumeDetail?

    // 입력 값
    @Published var newReviewRating = 0
    @Published var reviewText = ""

    // UI 값
    @Published var hasUserReviewed = false
    @Published var showReviewPopup = false

    // 유저 정보 (임시)
    struct User {
        let maskedName: String
    }
    @Published var currentUser = User(maskedName: "user***")

    let perfumeId: Int
    let provider = MoyaProvider<PerfumeAPI>(plugins: [AuthPlugin(), NetworkLoggerPlugin()])

    init(perfumeId: Int) {
        self.perfumeId = perfumeId
        fetchDetail()
    }

    // MARK: - 상세 조회
    func fetchDetail() {
        provider.request(.getPerfumeDetail(id: perfumeId, page: 0, size: 10)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(PerfumeDetail.self, from: response.data)
                    DispatchQueue.main.async {
                        self.perfume = decoded
                    }
                } catch {
                    print("디코딩 실패", error)
                    print(String(data: response.data, encoding: .utf8) ?? "no data")
                }

            case .failure(let error):
                print("요청 실패", error)
            }
        }
    }

    // MARK: - 리뷰 작성
    func submitReview() {
        provider.request(.postReview(id: perfumeId, score: newReviewRating, content: reviewText)) { result in
            switch result {
            case .success(let response):
                print("리뷰 작성 성공:", response)

                DispatchQueue.main.async {
                    self.showReviewPopup = true
                    self.hasUserReviewed = true
                    self.reviewText = ""
                    self.newReviewRating = 0

                    self.fetchDetail()
                }

            case .failure(let error):
                print("리뷰 작성 실패:", error)
            }
        }
    }
}
