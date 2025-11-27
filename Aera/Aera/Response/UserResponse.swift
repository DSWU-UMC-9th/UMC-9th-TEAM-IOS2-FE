//
//  UserResponse.swift
//  Aera
//
//  Created by 정서영 on 11/28/25.
//

struct SignupResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: SignupResult?
}

struct SignupResult: Decodable {
    let memberId: Int
    let createAt: String
}

struct LoginResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: LoginResult?
}

struct LoginResult: Decodable {
    let memberId: Int
    let name: String
    let accessToken: String
}
