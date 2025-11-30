//
//  PerfumeListViewModel.swift
//  Aera
//
//  Created by Jung Hyun Han on 11/27/25.
//

import Foundation
import Combine
import Moya

class PerfumeListViewModel: ObservableObject {
    @Published var perfumes: [Perfume] = []
    @Published var recommended: [Perfume] = []
    
    private var cancellables = Set<AnyCancellable>()
    let provider = MoyaProvider<APIService>(
        plugins: [
            AuthPlugin(tokenClosure: { KeychainManager.shared.getAccessToken() }),
            NetworkLoggerPlugin()
        ]
    )


    
    init() {
        fetchPerfumes(sort: "desc")
    }
    
    func fetchPerfumes(sort: String) {
        guard let url = URL(string: "http://localhost:8080/perfumes/main?sort=\(sort)") else {
            print("잘못된 URL")
            return
        }
        
        print("요청 URL:", url) // 디버깅용
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PerfumeResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let err) = completion {
                    print("서버 통신 오류:", err)
                }
            } receiveValue: { response in
                self.recommended = response.recommendedPerfumes
                self.perfumes = response.perfumes
            }
            .store(in: &cancellables)
    }
}
