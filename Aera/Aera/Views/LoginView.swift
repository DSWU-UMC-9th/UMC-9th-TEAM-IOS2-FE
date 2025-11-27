//
//  LoginView.swift
//  Aera
//
//  Created by 김미주 on 11/15/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = UserViewModel()
    
    var body: some View {
        ZStack {
            Color.aricticLight
            
            VStack{
                Image(.logoDark)
                    .padding(.bottom, 44)
                InfoGroup
                    .padding(.bottom, 24)
                InputGroup
                    .padding(.bottom, 32)
                ButtonGroup
            }
        }
        .ignoresSafeArea()
    }
    
    private var InfoGroup: some View {
        VStack(spacing: 8){
            Text("로그인 하기")
                .font(.MBold)
            Text("아이디와 비밀번호를 입력하세요")
                .font(.SMedium)
        }
    }
    
    private var InputGroup: some View {
        VStack(spacing: 16){
            InputView{
                TextField("아이디를 입력하세요", text: $viewModel.id)
            }
            InputView{
                HStack{
                    if !viewModel.showPassword {
                        SecureField("비밀번호를 입력하세요", text: $viewModel.password)
                        Button(action: {viewModel.showPassword.toggle()}, label: {
                            Image(.iconEyeOff)
                        })
                    } else {
                        TextField("비밀번호를 입력하세요", text: $viewModel.password)
                        Button(action: {viewModel.showPassword.toggle()}, label: {
                            Image(.iconEyeOn)
                        })
                    }
                }
            }
        }
        .padding(.horizontal, 24)
    }
    
    private var ButtonGroup: some View {
        VStack(spacing: 24){
            Button(action: {}, label: {
                Text("로그인")
                    .font(.SMedium)
                    .foregroundStyle(.aricticLight)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundStyle(.midnightDark)
                    )
            })
            
            HStack(spacing: 8) {
                Rectangle()
                    .fill(.aricticDark)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                
                Text("또는")
                    .font(.SMedium)
                    .foregroundStyle(.aricticDark)
                
                Rectangle()
                    .fill(.aricticDark)
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
            }
            
            Button(action: {}, label: {
                Text("회원가입 하러 가기")
                    .font(.SMedium)
                    .foregroundStyle(.midnightDark)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(.midnightDark), lineWidth: 1)
                    )
            })
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    LoginView()
}
