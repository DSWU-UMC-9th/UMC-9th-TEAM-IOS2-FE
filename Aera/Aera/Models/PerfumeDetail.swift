//
//  PerfumeDetail.swift
//  Aera
//
//  Created by Jung Hyun Han on 11/30/25.
//

import Foundation

// MARK: - 향수 상세 모델
struct PerfumeDetail: Codable, Identifiable {
    let id: Int
    let name: String
    let brand: String
    let priceText: String
    let description: String
    let imageUrl: String
    let avgScore: Double
    let reviewCount: Int
    let reviews: ReviewPage
}

// MARK: - 리뷰 페이지네이션
struct ReviewPage: Codable {
    let totalCount: Int
    let page: Int
    let size: Int
    let hasNext: Bool
    let items: [ReviewItem]
}

// MARK: - 단일 리뷰 아이템
struct ReviewItem: Codable, Identifiable {
    let id: Int          // reviewId
    let score: Int
    let writerName: String
    let content: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "reviewId"
        case score
        case writerName
        case content
        case updatedAt
    }

    // MARK: - 마스킹된 이름
    var maskedWriterName: String {
        let prefix = writerName.count >= 4 ? String(writerName.prefix(4)) : writerName
        return prefix + "****"
    }

    // MARK: - 날짜 포맷
    var formattedDate: String {
            // (1) fractional 제거 또는 3자리로 줄이기
            let cleaned: String = {
                if let dotIndex = updatedAt.firstIndex(of: ".") {
                    let prefix = updatedAt[..<dotIndex]            // 2025-11-30T12:58:38
                    let fraction = updatedAt[updatedAt.index(after: dotIndex)...] // 585922
                    
                    let trimmed = fraction.prefix(3)               // 585
                    return "\(prefix).\(trimmed)"
                }
                return updatedAt
            }()

            // (2) ISO8601 파서
            let iso = ISO8601DateFormatter()
            iso.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

            if let date = iso.date(from: cleaned) {
                let out = DateFormatter()
                out.dateFormat = "yyyy-MM-dd"
                return out.string(from: date)
            }

            // (3) 수동 파싱 fallback
            let manual = DateFormatter()
            manual.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            if let date = manual.date(from: cleaned) {
                let out = DateFormatter()
                out.dateFormat = "yyyy-MM-dd"
                return out.string(from: date)
            }

            return updatedAt
        }
    }
