//
//  MyPageViewModel.swift
//  Aera
//
//  Created by 권예원 on 11/24/25.
//

import SwiftUI
import Combine
import Moya

class MyPageViewModel: ObservableObject {
    @Published var myInfo: MyPageUser? = nil
    @Published var myReviews: [MyPageReview] = []
    @Published var sortOption: SortOption = .latest
    
    private let provider = APIManager.shared.createProvider(for: APIService.self)

    enum SortOption: String {
        case latest = "latest"
        case oldest = "oldest"
    }

    init() {
        fetchMyInfo()
        fetchMyReviews()
    }
    
    
    func fetchMyInfo() {
        provider.request(.getMyInfo) { result in
            switch result {
            case .success(let response):
                
                print("🔍 MyInfo Raw Response:")
                print(String(data: response.data, encoding: .utf8) ?? "❌ Invalid UTF-8")

                do {
                    let dto = try JSONDecoder().decode(MyPageResponse.self, from: response.data)
                    DispatchQueue.main.async { self.myInfo = dto.result }
                } catch {
                    print("MyPage Info decode error:", error)
                }
                
            case .failure(let error):
                print("MyPage Info request error:", error)
            }
        }
    }
    

    func fetchMyReviews() {
        provider.request(.getMyReviews(sort: sortOption.rawValue)) { [weak self] result in
            
            switch result {
            case .success(let response):
                do {
                    let dto = try JSONDecoder().decode(MyPageReviewListResponse.self, from: response.data)
                    DispatchQueue.main.async { self?.myReviews = dto.result }
                } catch {
                    print("MyPage Review decode error:", error)
                }
                
            case .failure(let error):
                print("MyPage Review network error:", error)
            }
        }
    }
    
    
    func sortReviewsLocally() {
        switch sortOption {
        case .latest:
            myReviews.sort { $0.createdDate > $1.createdDate }
        case .oldest:
            myReviews.sort { $0.createdDate < $1.createdDate }
        }
    }

}
