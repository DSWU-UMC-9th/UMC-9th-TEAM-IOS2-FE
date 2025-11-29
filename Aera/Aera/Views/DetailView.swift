//
//  DetailView.swift
//  Aera
//
//  Created by 김미주 on 11/15/25.
//

import SwiftUI


struct DetailView: View {
    @StateObject private var vm = DetailViewModel()
    @FocusState private var isReviewFocused: Bool
    
    var body: some View {
        ZStack {
            Color.aricticLight
            
            VStack{
                Header()
                ScrollView {
                    MainImage
                    Spacer().frame(height: 20)

                    Group{
                        productHeaderSection
                        Spacer().frame(height: 20)
                        Description
                        Spacer().frame(height: 40)
                        Reviews
                    }
                    .padding(.horizontal, 24)
                }
                if vm.showReviewPopup {
                    ReviewSuccessPopup {
                        vm.showReviewPopup = false
                    }
                    .transition(.scale.combined(with: .opacity))
                    .animation(.easeInOut, value: vm.showReviewPopup)
                }
            }

        }
        .ignoresSafeArea()
    }
    
    var MainImage: some View {
        Image(vm.product.imageURL)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity)
    }
    
    var productHeaderSection : some View {
        VStack(alignment: .leading) {
            HStack{
                Text(vm.product.name)
                    .font(.XlSemiBold)
                    .foregroundStyle(.midnightDark)
                Spacer()
                RatingSummaryView(
                    rating: vm.product.rating,
                    reviewCount: vm.product.reviewCount
                )
            }
            Spacer().frame(height: 4)
            Text(vm.product.brand)
                .font(.XsMedium)
                .foregroundStyle(.aricticDarkHover)
            Spacer().frame(height: 10)
            Text("\(vm.product.price) (\(vm.product.volume))")
                .font(.SSemiBold)
                .foregroundStyle(.midnightDark)
        }
    }
    
    var Description: some View {
        Text(vm.product.description)
            .font(.XsMedium)
            .foregroundStyle(.aricticDarker)
            .lineSpacing(4)
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .foregroundStyle(.aricticLightActive)
            )
    }
    
    var Reviews: some View {
        VStack(alignment: .leading) {
            Text("향수 리뷰 (\(vm.product.reviewCount))")
                .font(.MBold)
                .foregroundStyle(.midnightDark)
                .padding(.bottom, 24)
            
            if !vm.hasUserReviewed {
                ReviewInputSection
                    .padding(.bottom, 48)
            }
            ReviewListSection
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
                    .frame(maxWidth: .infinity)
                    .scrollContentBackground(.hidden)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(.aricticLightActive, lineWidth: 1)
                            .foregroundStyle(.slopesWhite)
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
                    .frame(height: 40)
                    .background(
                        vm.canSubmitReview ? Color.midnightDark : Color.gray.opacity(0.3)
                    )
                    .foregroundStyle(.aricticLight)
                    .cornerRadius(4)
            }
            .disabled(!vm.canSubmitReview)
        }
    
    }
    
    var ReviewListSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(Array(vm.product.reviews.enumerated()), id: \.element.id) { index, review in
                VStack(alignment: .leading, spacing: 12) {
                    
                    HStack {
                        StarStaticView(rating: review.rating)
                        
                        Spacer().frame(width:13)
                        
                        Text(review.userNameMasked)
                            .font(.XsMedium)
                            .foregroundStyle(.aricticDarker)
                    
                        Spacer()
                        
                        Text(review.date)
                            .font(.XsMedium)
                            .foregroundStyle(.aricticDark)
                    }
                    
                    Text(review.content)
                        .font(.SMedium)
                        .foregroundStyle(.aricticDarker)
                        .lineSpacing(5.6)
                    
                    if review.userID == vm.currentUser.id {
                        HStack {
                            Spacer()

                            Button(action: {
                                
                            }) {
                                Text("수정하기")
                                    .font(.XxsMedium)
                                    .frame(width: 55)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(.aricticDark, lineWidth: 1)
                                    )
                                    .foregroundColor(.aricticDark)
                            }
                        }
                    }
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
    DetailView()
}
