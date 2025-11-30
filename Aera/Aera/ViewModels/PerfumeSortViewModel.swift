//
//  PerfumeSortViewModel.swift
//  Aera
//
//  Created by Jung Hyun Han on 11/27/25.
//

import Foundation
import SwiftUI
import Combine

class PerfumeSortViewModel: ObservableObject {
    @Published var isDropdownOpen = false
    @Published var selectedSort: String = "평점 높은 순"
    
    var sortParameter: String {
        selectedSort == "평점 높은 순" ? "desc" : "asc"
    }
    
    let sortOptions = [
        "평점 높은 순",
        "평점 낮은 순"
    ]
}
