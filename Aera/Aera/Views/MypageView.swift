//
//  MypageView.swift
//  Aera
//
//  Created by 김미주 on 11/15/25.
//

import SwiftUI

struct MypageView: View {
    @StateObject private var vm = MyPageViewModel()
    @State private var isDropdownExpanded = false
    @State private var sortButtonFrame: CGRect = .zero

    @State private var goMyPage = false

    
    var body: some View {
        ZStack {
            Color.aricticLight
            VStack{
                Header {
                    goMyPage = true
                }
                ScrollView {
                    UserNameCard
                        .padding(.vertical, 24)
                    SortSection
                        .padding(.bottom, 24)
                    reviewListSection
                }
                .padding(.horizontal,24)
            }
            
        }
        .overlay(alignment: .topLeading) {
            if isDropdownExpanded {
                sortDropDown
                    .position(
                        x: sortButtonFrame.maxX - 35,
                        y: sortButtonFrame.maxY + 32
                    )
                    .zIndex(999)
            }
        }
        .ignoresSafeArea()
    }
    
    var UserNameCard: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("안녕하세요")
                    .font(.SSemiBold)
                    .foregroundStyle(.aricticLightHover)

                Text("\(vm.myInfo?.name ?? "") 님")
                    .font(.LSemiBold)
                    .foregroundStyle(.aricticLight)
            }
            Spacer()
        }
        .padding(16)
        .background(.midnightDark)
        .cornerRadius(4)
    }
    
    var SortSection: some View {
        HStack {
            Text("내가 작성한 리뷰")
                .font(.MBold)
                .foregroundStyle(.midnightDark)

            Spacer()

            Button {
                isDropdownExpanded.toggle()
            } label: {
                HStack {
                    Text(vm.sortOption == .latest ? "최신 순" : "오래된 순")
                    Image(systemName: isDropdownExpanded ? "chevron.up" : "chevron.down")
                        .resizable()
                        .frame(width: 8, height: 4)
                }
                .foregroundColor(.aricticLightHover)
                .font(.XxsMedium)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .frame(width: 70, height: 24)
                .background(.midnightDark)
                .cornerRadius(4)
            }
            .background(
                GeometryReader { geo in
                    let frame = geo.frame(in: .global)

                    Color.clear
                        .onAppear {
                            sortButtonFrame = frame
                        }
                        .onChange(of: frame) { oldFrame, newFrame in
                            sortButtonFrame = newFrame
                        }
                }
            )

        }
    }

    
    
    var reviewListSection: some View {
        VStack(spacing: 16) {
            ForEach(vm.myReviews, id: \.reviewId) { review in
                ReviewCard(review: review)
            }
        }
    }
    var sortDropDown: some View {
        VStack(spacing: 0) {
            Button("최신 순") {
                vm.sortOption = .latest
                isDropdownExpanded = false
            }
            .frame(height: 24)
            
            Button("오래된 순") {
                vm.sortOption = .oldest
                isDropdownExpanded = false
            }
            .frame(height: 24)
        }
        .foregroundColor(.aricticLightHover)
        .font(.XxsMedium)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .frame(width:70)
        .background(.midnightDark)
        .cornerRadius(4)
    }
}


struct ReviewCard: View {
    let review: MyPageReview

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(review.perfumeName)
                    .font(.LSemiBold)
                    .foregroundStyle(.midnightDark)

                Spacer()

                Button {
                    // 향수 상세 페이지로 이동
                } label: {
                    HStack {
                        Text("보러가기")
                            .font(.XsMedium)
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width: 7, height: 12)
                    }
                    .foregroundStyle(.aricticDark)
                }
            }

            Divider().padding(.bottom, 16)

            HStack {
                StarStaticView(rating: review.rating)

                Spacer().frame(width: 13)

                Text(review.maskedMemberId)
                    .font(.XsMedium)
                    .foregroundStyle(.aricticDarker)

                Spacer()

                Text(review.createdDate)
                    .font(.XsMedium)
                    .foregroundStyle(.aricticDark)
            }
            .padding(.bottom, 12)

            Text(review.content)
                .font(.SMedium)
                .foregroundStyle(.aricticDarker)
                .lineSpacing(5.6)
        }
        .padding(16)
        .background(.slopesWhite)
        .cornerRadius(4)
    }
}


#Preview {
    MypageView()
}
