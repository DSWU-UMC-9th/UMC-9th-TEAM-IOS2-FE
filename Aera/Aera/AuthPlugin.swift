//
//  AuthPlugin.swift
//  Aera
//
//  Created by 권예원 on 11/29/25.
//

import Foundation
import Moya

final class AuthPlugin: PluginType {
    private let tokenClosure: () -> String?

    init(tokenClosure: @escaping () -> String?) {
        self.tokenClosure = tokenClosure
    }

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        
        if let token = KeychainManager.shared.getAccessToken() {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
    
    
}

