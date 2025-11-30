//
//  responseDTO.swift
//  Aera
//
//  Created by 권예원 on 11/27/25.
//

import Foundation

// 상세
struct PerfumeDetailResponse: Decodable {
    let id: Int
    let name: String
    let brand: String
    let imageUrl: String
    let avgScore: Double
    let reviewCount: Int
    let description: String
    let notes: Notes
    let reviews: [PerfumeReview]
}


struct Notes: Decodable {
    let top: [String]
    let middle: [String]
    let base: [String]
}

struct PerfumeReview: Decodable {
    let id: Int
    let memberId: Int
    let memberName: String
    let score: Int
    let content: String
    let createdAt: String
}

// 리뷰 작성 - 요청
struct CreateReviewRequestDTO: Codable {
    let score: Int
    let content: String
}

// 리뷰 작성 - 응답
struct CreateReviewResponseDTO: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ReviewResult

    struct ReviewResult: Codable {
        let reviewId: Int
        let score: Int
        let writerName: String
        let content: String
        let updatedAt: String
    }
}



// 마이페이지
struct MyPageResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: MyPageUser
}

struct MyPageUser: Codable {
    let email: String
    let name: String
}

struct MyPageReviewListResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: [MyPageReview]
}

struct MyPageReview: Codable {
    let reviewId: Int
    let perfumeName: String
    let maskedMemberId: String
    let rating: Int
    let content: String
    let createdDate: String
}


struct ReviewExistResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: Bool
}


enum ProductMapper {

    // 상세 페이지용 맵핑
    static func mapDetail(_ dto: PerfumeDetailResponse) -> Product {
        return Product(
            id: dto.id,
            imageURL: dto.imageUrl,
            name: dto.name,
            brand: dto.brand,
            description: dto.description,
            rating: dto.avgScore,
            reviewCount: dto.reviewCount,
            notes: PerfumeNotes(
                top: dto.notes.top,
                middle: dto.notes.middle,
                base: dto.notes.base
            ),
            reviews: dto.reviews.map { mapPerfumeReview($0) }
        )
    }

    // 상세페이지 리뷰 변환
    static func mapPerfumeReview(_ dto: PerfumeReview) -> Review {
        return Review(
            id: dto.id,
            userID: dto.memberId,
            userNameMasked: dto.memberName,
            rating: dto.score,
            content: dto.content,
            date: dto.createdAt
        )
    }

}
