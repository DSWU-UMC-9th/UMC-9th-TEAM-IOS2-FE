//
//  CurrentUser.swift
//  Aera
//
//  Created by Jung Hyun Han on 11/30/25.
//

import Foundation

struct CurrentUser {
    let id: Int
    let name: String
    
    var maskedName: String {
        guard let first = name.first else { return name }
        return "\(first)***"
    }
}

