//
//  DetailView.swift
//  Aera
//
//  Created by 김미주 on 11/15/25.
//

import SwiftUI

struct DetailView: View {
    let perfumeId: Int
    
    @State private var goMain = false
    @State private var goMyPage = false
    
    @StateObject private var vm: DetailViewModel
    @FocusState private var isReviewFocused: Bool
    
    init(perfumeId: Int) {
        self.perfumeId = perfumeId
        _vm = StateObject(wrappedValue: DetailViewModel(perfumeId: perfumeId))
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.aricticLight
                
                VStack{
                    Header(
                        onTapMyPage: { goMyPage = true },
                        onTapLogo: { goMain = true }
                    )
                    ScrollView {
                        if let perfume = vm.perfume {
                            
                            MainImage(perfume)
                            
                            Spacer().frame(height: 20)
                            
                            Group {
                                productHeaderSection(perfume)
                                Spacer().frame(height: 20)
                                Description(perfume)
                                Spacer().frame(height: 40)
                                Reviews(perfume)
                            }
                            .padding(.horizontal, 24)
                        }
                    }

                }
                if vm.showReviewPopup {
                    ReviewSuccessPopup {
                        vm.showReviewPopup = false
                    }
                    .transition(.scale.combined(with: .opacity))
                    .animation(.easeInOut, value: vm.showReviewPopup)
                }
            }
            .ignoresSafeArea()
            .navigationDestination(isPresented: $goMain) {
                MainView()
                    .navigationBarBackButtonHidden()
            }
            .navigationDestination(isPresented: $goMyPage) {
                MypageView()
                    .navigationBarBackButtonHidden()
            }
        }
    }
    
    @ViewBuilder
    func MainImage(_ p: PerfumeDetail) -> some View {
        AsyncImage(url: URL(string: "http://localhost:8080\(p.imageUrl)")) { img in
            img.resizable()
        } placeholder: {
            Rectangle().fill(Color.gray.opacity(0.2))
        }
        .scaledToFit()
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    func productHeaderSection(_ p: PerfumeDetail) -> some View {
        VStack(alignment: .leading) {
            HStack{
                Text(p.name)
                    .font(.XlSemiBold)
                    .foregroundStyle(.midnightDark)
                Spacer()
                RatingSummaryView(
                    rating: p.avgScore,
                    reviewCount: p.reviewCount
                )
            }
            Spacer().frame(height: 4)
            Text(p.brand)
                .font(.XsMedium)
                .foregroundStyle(.aricticDarkHover)
            Spacer().frame(height: 10)
            Text(p.priceText)
                .font(.SSemiBold)
                .foregroundStyle(.midnightDark)
        }
    }
    
    @ViewBuilder
    func Description(_ p: PerfumeDetail) -> some View {
        Text(p.description)
            .font(.XsMedium)
            .foregroundStyle(.aricticDarker)
            .lineSpacing(4)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .foregroundStyle(.aricticLightActive)
            )
    }
    
    @ViewBuilder
    func Reviews(_ p: PerfumeDetail) -> some View {
          VStack(alignment: .leading) {
              Text("향수 리뷰 (\(p.reviewCount))")
                  .font(.MBold)
                  .foregroundStyle(.midnightDark)
                  .padding(.bottom, 24)
              
              if !vm.hasUserReviewed {
                  ReviewInputSection
                      .padding(.bottom, 48)
              }
              ReviewListSection(p)
          }
          .padding(.top, 30)
      }
    
    var ReviewInputSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            HStack{
                StarRatingView(rating: $vm.newReviewRating)
                Spacer()
                Text(vm.currentUser.maskedName)
                    .font(.XsMedium)
                    .foregroundStyle(.aricticDarkHover)
            }
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $vm.reviewText)
                    .focused($isReviewFocused)
                    .font(.XsMedium)
                    .padding(16)
                    .frame(height: 108)
                    .scrollContentBackground(.hidden)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(.aricticLightActive, lineWidth: 1)
                    )

                if !isReviewFocused && vm.reviewText.isEmpty {
                    Text("리뷰를 작성해 주세요 (1000자 이내)")
                        .foregroundColor(.aricticDarkHover.opacity(0.5))
                        .font(.XsMedium)
                        .padding(16)
                }
            }
            
            Button(action: { vm.submitReview() }) {
                Text("리뷰 등록하기")
                    .font(.SMedium)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(vm.reviewText.isEmpty ? Color.gray.opacity(0.3) : Color.midnightDark)
                    .foregroundStyle(.aricticLight)
                    .cornerRadius(4)
            }
            .disabled(vm.reviewText.isEmpty)
        }
    }
    
    @ViewBuilder
    func ReviewListSection(_ p: PerfumeDetail) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(p.reviews.items) { review in
                VStack(alignment: .leading, spacing: 12) {
                    
                    HStack {
                        StarStaticView(rating: review.score)
                        
                        Spacer().frame(width: 13)
                        
                        Text(review.maskedWriterName)
                            .font(.XsMedium)
                            .foregroundStyle(.aricticDarker)
                    
                        Spacer()
                        
                        Text(review.formattedDate)
                            .font(.XsMedium)
                            .foregroundStyle(.aricticDark)
                    }
                    
                    Text(review.content)
                        .font(.SMedium)
                        .foregroundStyle(.aricticDarker)
                        .lineSpacing(5.6)
                }
                
                Divider().padding(.vertical, 12)
            }
        }
        .padding(.top, 12)
    }
}



struct StarRatingView: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(1...5, id: \.self) { i in
                Image(i <= rating ? "icon_star_fill" : "icon_star_empty")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .onTapGesture { rating = i }
            }
        }
    }
}

struct ReviewSuccessPopup: View {
    var onClose: () -> Void

    var body: some View {
        VStack(spacing: 25) {

            Text("리뷰가 등록되었습니다!")
                .font(.LSemiBold)
                .foregroundStyle(.black)
                .padding(.horizontal, 42)
                .padding(.vertical, 13)

            Button(action: onClose) {
                Text("확인")
                    .font(.headline)
                    .frame(width: 296)
                    .padding(.vertical, 14)
                    .background(.midnightDark)
                    .foregroundColor(.aricticLight)
                    .cornerRadius(10)
            }

        }
        .padding(.top, 24)
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .frame(width:326)
                .foregroundStyle(.aricticLight)
        )
    }
}


#Preview {
    DetailView(perfumeId: 2)
}
