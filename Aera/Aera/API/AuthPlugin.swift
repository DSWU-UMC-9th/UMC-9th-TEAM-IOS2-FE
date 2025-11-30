//
//  AuthPlugin.swift
//  Aera
//
//  Created by Jung Hyun Han on 11/30/25.
//

import Moya
import Foundation

final class AuthPlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        
        if let token = KeychainManager.shared.loadTokenString() {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}
