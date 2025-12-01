//
//  MainView.swift
//  Aera
//
//  Created by 김미주 on 11/15/25.
//

import SwiftUI
import Combine

struct MainView: View {
    
    @StateObject private var sortVM = PerfumeSortViewModel()
    @StateObject private var perfumeVM = PerfumeListViewModel()
    
    @State private var goMyPage = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.aricticLight.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        Header {
                            goMyPage = true
                        }
                        sectionRecommend
                        
                        Image("Banner")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 327, height: 195)
                        
                        perfumeListHeader
                        
                        LazyVGrid(columns: columns, spacing: 24) {
                            ForEach(perfumeVM.perfumes) { perfume in
                                NavigationLink(destination: DetailView(perfumeId: perfume.id)) {
                                    PerfumeItem(perfume: perfume)
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 20)
                    }
                }
                .ignoresSafeArea()
            }
            .navigationDestination(isPresented: $goMyPage) {
                MypageView()
                    .navigationBarBackButtonHidden()
            }
        }
        .environmentObject(sortVM)
        .onChange(of: sortVM.selectedSort) { _, _ in
            perfumeVM.fetchPerfumes(sort: sortVM.sortParameter)
        }
    }
}

extension MainView {

    var sectionRecommend: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("지금 추천하는 향수")
                .font(.MBold)
                .foregroundStyle(.black)

            Text("가장 많은 분들이 리뷰로 추천한 제품입니다.")
                .font(.XsMedium)
                .foregroundStyle(.aricticDark)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
        .padding(.bottom, 24)
    }

    // MARK: - 드롭다운과 겹치는 헤더
    var perfumeListHeader: some View {
        ZStack(alignment: .topTrailing) {

            // 기본 헤더
            HStack {
                Text("향수 목록")
                    .font(.MBold)
                    .foregroundStyle(.black)

                Spacer()

                SortDropdown()
                    .environmentObject(sortVM)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 24)

            if sortVM.isDropdownOpen {
                SortDropdownMenu()
                    .environmentObject(sortVM)
                    .padding(.trailing, 24)
                    .padding(.top, 60)
                    .transition(.opacity)
                    .zIndex(10)
            }
        }
    }
}


// MARK: - Sort Button
struct SortDropdown: View {
    @EnvironmentObject var vm: PerfumeSortViewModel

    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                vm.isDropdownOpen.toggle()
            }
        } label: {
            HStack(spacing: 8) {
                Text(vm.selectedSort)
                    .font(.XsMedium)
                    .foregroundStyle(.aricticLight)

                Image(systemName: vm.isDropdownOpen ? "chevron.up" : "chevron.down")
                    .font(.XxsMedium)
                    .foregroundStyle(.aricticLight)
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(Color.midnightDark)
            .cornerRadius(4)
        }
    }
}


// MARK: - Dropdown Menu
struct SortDropdownMenu: View {
    @EnvironmentObject var vm: PerfumeSortViewModel

    var body: some View {
        VStack(spacing: 0) {
            ForEach(vm.sortOptions, id: \.self) { option in
                Button {
                    vm.selectedSort = option
                    withAnimation(.easeInOut(duration: 0.15)) {
                        vm.isDropdownOpen = false
                    }
                } label: {
                    Text(option)
                        .font(.XsMedium)
                        .foregroundStyle(.aricticLight)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                }
            }
        }
        .background(Color.midnightDark)
        .cornerRadius(4)
    }
}


// MARK: - Perfume Item
struct PerfumeItem: View {
    let perfume: Perfume
    
    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: "http://localhost:8080\(perfume.imageUrl)")) { img in
                            img.resizable()
                        } placeholder: {
                            Color.gray.opacity(0.2)
                        }
                        .frame(width: 152, height: 152)

            VStack(spacing: 5) {
                Text(perfume.name)
                    .font(.SSemiBold)
                    .foregroundStyle(.aricticDarker)
                    .lineLimit(1)
                    .frame(width: 152, alignment: .leading)

                HStack(spacing: 8) {
                    HStack(spacing: 2) {
                        ForEach(0..<5) { index in
                            Image(systemName: "star.fill")
                                .font(.caption2)
                                .foregroundStyle(
                                    index < Int(perfume.avgScore.rounded(.down))
                                    ? .aricticDarker
                                    : .aricticNormal
                                )
                        }

                        Text(String(format: "%.1f", perfume.avgScore))
                            .font(.XsMedium)
                            .foregroundStyle(.aricticNormal)

                        Text("(\(perfume.reviewCount))")
                            .font(.XsMedium)
                            .foregroundStyle(.aricticNormal)
                    }
                }
                .frame(width: 152, alignment: .leading)
            }
        }
    }
}

#Preview {
    MainView()
}
