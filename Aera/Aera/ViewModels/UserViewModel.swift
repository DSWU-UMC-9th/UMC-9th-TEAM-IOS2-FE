//
//  UserViewModel.swift
//  Aera
//
//  Created by 정서영 on 11/27/25.
//

import SwiftUI
import Combine
import Moya

class UserViewModel: ObservableObject {

    @Published var id: String = ""
    @Published var password: String = ""
    @Published var passwordCheck: String = ""

    @Published var showPassword: Bool = false
    @Published var showPasswordCheck: Bool = false

    @Published var errorMessage: String?
    @Published var isSuccess: Bool = false
    
    var signupData: SignupData?
    private let provider = APIManager.shared.createProvider(for: UserRouter.self)
    
    func signup() {
        provider.request(.signup(signupData: SignupData(name: id, email: password, password: passwordCheck))) {
            result in switch result {
            case .success(let response):
                if let decodedResponse = try? JSONDecoder().decode(SignupResponse.self, from: response.data) {
                    print("성공: \(decodedResponse.message)")
                    self.isSuccess = true
                }
            case .failure(let error):
                if let response = error.response {
                    do {
                        let decodedResponse = try JSONDecoder().decode(SignupResponse.self, from: response.data)
                        print(decodedResponse)
                        print("실패 : \(error.localizedDescription)")

                    } catch {
                        print("디코딩 실패 : \(error.localizedDescription)")
                    }
                } else {
                    print("네트워크 오류: \(error.localizedDescription)")
                }
            }
        }
    }
}
