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

    case getPerfumeDetail(perfumeId: Int)
    
    case createReview(perfumeId: Int, content: String, rating: Int)
//    case updateReview(perfumeId: Int, reviewId: Int, content: String, rating: Int)
    
    case getMyInfo
    case getMyReviews(sort:String)
    case checkReviewExists(reviewId: Int)
}

protocol APITargetType : TargetType {}

extension APITargetType {
    var baseURL: URL{
        return URL(string: "http://localhost:8080")!
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}


extension APIService : APITargetType {

    var path: String {
        switch self {
            case let .getPerfumeDetail(id):
                return "/perfumes/\(id)"
                    
            case let .createReview(perfumeId, _, _):
                return "/perfumes/\(perfumeId)/reviews"
                    
            case .getMyInfo:
                return "/api/mypage/me"
            case .getMyReviews:
                return "/api/mypage/perfume-reviews"
            case let .checkReviewExists(reviewId):
                return "/api/mypage/perfume-reviews/\(reviewId)/exists"
        }
    }
    
    var method: Moya.Method {
        switch self {
                
            case .getPerfumeDetail,
                 .getMyInfo,
                 .getMyReviews,
                 .checkReviewExists:
                return .get
                
            case .createReview:
                return .post
        }
    }
    
    var task: Task {
        switch self {
            case .getPerfumeDetail,
                 .getMyInfo,
                 .checkReviewExists:
                return .requestPlain
            case .getMyReviews(let sort):
                return .requestParameters(
                    parameters: ["sort": sort],
                    encoding: URLEncoding.queryString
                )
            case let .createReview(_, content, rating):
                let body: [String: Any] = [
                    "score": rating,
                    "content": content
                ]
                return .requestParameters(parameters: body, encoding: JSONEncoding.default)
        }
    }
}

