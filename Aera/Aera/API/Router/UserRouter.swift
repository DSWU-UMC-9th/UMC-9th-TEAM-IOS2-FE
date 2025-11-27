//
//  UserRouter.swift
//  Aera
//
//  Created by 정서영 on 11/28/25.
//

import Foundation
import Moya
import Alamofire

enum UserRouter {
    case signup(signupData: SignupData)
    case login(loginData: LoginData)
}

extension UserRouter: APITargetType {
    
    var path: String {
        switch self {
        case .signup:
            return "/sign-up"
        case .login:
            return "/sign-in"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signup, .login:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .signup(let signupData):
            return .requestJSONEncodable(signupData)
        case .login(let loginData):
            return .requestJSONEncodable(loginData)
        }
    }
}
