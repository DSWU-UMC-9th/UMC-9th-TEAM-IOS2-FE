//
//  UserModel.swift
//  Aera
//
//  Created by 정서영 on 11/27/25.
//

import SwiftUI

struct SignupData: Codable {
    let loginId: String
    let password: String
    let passwordCheck: String
}

struct LoginData: Codable {
    let loginId: String
    let password: String
}

struct TokenInfo: Codable {
    let accessToken: String
}
