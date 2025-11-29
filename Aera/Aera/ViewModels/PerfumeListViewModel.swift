//
//  PerfumeListViewModel.swift
//  Aera
//
//  Created by Jung Hyun Han on 11/27/25.
//

import Foundation
import Combine

class PerfumeListViewModel: ObservableObject {
    @Published var perfumes: [Perfume] = []
    @Published var recommended: [Perfume] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadMockData(sort: "desc")
    }
    
    // MARK: - 실제 연동 시 URLSession으로 교체
    func fetchPerfumes(sort: String) {
        // 나중에 서버 연동 시:
        // let url = URL(string: "https://yourserver.com/perfumes/main?sort=\(sort)")!
    }
    
    // MARK: - MOCK 데이터 + 정렬
    func loadMockData(sort: String) {
        let mock = [
            Perfume(id: 1, name: "티어즈 프롬 더 문", brand: "GUCCI", imageUrl: "/images/tears_from_the_moon.webp", avgScore: 4.8, reviewCount: 152),
            Perfume(id: 2, name: "스프링타임 인 파크", brand: "Maison Margiela", imageUrl: "/images/springtime_in_park.webp", avgScore: 4.6, reviewCount: 98),
            Perfume(id: 3, name: "오 드 뚜왈렛 오데썽", brand: "DIPTYQUE", imageUrl: "/images/eau_des_sens.webp", avgScore: 4.3, reviewCount: 60),
            Perfume(id: 4, name: "블랑쉬 오 드 퍼퓸", brand: "BYREDO", imageUrl: "/images/blanche.webp", avgScore: 4.1, reviewCount: 41),
            Perfume(id: 5, name: "퍼퓸 보타리", brand: "TAMBURINS", imageUrl: "/images/perfume_botari.webp", avgScore: 3.9, reviewCount: 32),
            Perfume(id: 6, name: "미드나이트 머스크 앤 앰버 코롱", brand: "JO MALONE", imageUrl: "/images/midnight_musk_amber.webp", avgScore: 3.5, reviewCount: 19),
            Perfume(id: 7, name: "어나더 13", brand: "LE LABO", imageUrl: "/images/another_13.webp", avgScore: 3.0, reviewCount: 11)
        ]
        
        if sort == "asc" {
            perfumes = mock.sorted { $0.avgScore < $1.avgScore }
        } else {
            perfumes = mock.sorted { $0.avgScore > $1.avgScore }
        }
        
        recommended = []
    }
}
