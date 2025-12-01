//
//  APIService.swift
//  Aera
//
//  Created by 권예원 on 11/27/25.
//

import Foundation
import Moya
import Alamofire

enum APIService {
    case getMyInfo
    case getMyReviews(sort: String)
    case checkReviewExists(reviewId: Int)
    case getPerfumeDetail(id: Int, page: Int, size: Int)
    case postReview(id: Int, score: Int, content: String)
}

extension APIService: APITargetType {

    var path: String {
        switch self {
        case .getMyInfo:
            return "/api/mypage/me"
        case .getMyReviews:
            return "/api/mypage/perfume-reviews"
        case .checkReviewExists(let reviewId):
            return "/api/mypage/perfume-reviews/\(reviewId)/exists"
        case .getPerfumeDetail(let id, _, _):
            return "/perfumes/\(id)"
        case .postReview(let id, _, _):
            return "/perfumes/\(id)/reviews"

        }
    }

    var method: Moya.Method {
        switch self {
            case .getMyInfo, .getMyReviews, .checkReviewExists, .getPerfumeDetail:
                return .get
            case .postReview:
                return .post
        }
    }

    var task: Task {
        switch self {
        case .getMyInfo, .checkReviewExists:
            return .requestPlain

        case .getMyReviews(let sort):
            return .requestParameters(
                parameters: ["sort": sort],
                encoding: URLEncoding.queryString
            )
        case .getPerfumeDetail(_, let page, let size):
            return .requestParameters(
                parameters: ["page": page, "size": size],
                encoding: URLEncoding.queryString
            )

        case .postReview(_, let score, let content):
            let body: [String: Any] = [
                "score": score,
                "content": content
            ]
            return .requestParameters(parameters: body, encoding: JSONEncoding.default)
        }
    }
}
