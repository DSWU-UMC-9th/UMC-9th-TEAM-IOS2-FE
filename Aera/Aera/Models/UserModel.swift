//
//  UserModel.swift
//  Aera
//
//  Created by 정서영 on 11/27/25.
//

import SwiftUI

struct SignupData: Codable {
    let name: String
    let email: String
    let password: String
}

struct LoginData: Codable {
    let email: String
    let password: String
}
