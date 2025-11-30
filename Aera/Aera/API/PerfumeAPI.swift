//
//  PerfumeAPI.swift
//  Aera
//
//  Created by Jung Hyun Han on 11/30/25.
//

import Foundation
import Moya
import Alamofire

enum PerfumeAPI {
    case getPerfumeDetail(id: Int, page: Int, size: Int)
    case postReview(id: Int, score: Int, content: String)
}

extension PerfumeAPI: TargetType {

    var baseURL: URL {
        return URL(string: "http://localhost:8080")!
    }

    var path: String {
        switch self {
        case .getPerfumeDetail(let id, _, _):
            return "/perfumes/\(id)"
        case .postReview(let id, _, _):
            return "/perfumes/\(id)/reviews"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getPerfumeDetail:
            return .get
        case .postReview:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {

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

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
