//
//  UserViewModel.swift
//  Aera
//
//  Created by 정서영 on 11/27/25.
//

import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var password: String = ""
    @Published var passwordCheck: String = ""

    @Published var showPassword: Bool = false
    @Published var showPasswordCheck: Bool = false

    @Published var errorMessage: String?
    @Published var isSuccess: Bool = false
}
