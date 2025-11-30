//
//  ReviewCreateResponse.swift
//  Aera
//
//  Created by Jung Hyun Han on 11/30/25.
//

import Foundation

struct ReviewCreateResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: ReviewCreateResult
}

struct ReviewCreateResult: Codable {
    let reviewId: Int
    let score: Int
    let writerName: String
    let content: String
    let updatedAt: String
}

struct ReviewRequest: Encodable {
    let score: Int
    let content: String
}
