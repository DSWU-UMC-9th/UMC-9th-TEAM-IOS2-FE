//
//  SignupView.swift
//  Aera
//
//  Created by 김미주 on 11/15/25.
//

import SwiftUI

struct SignupView: View {
    @StateObject var viewModel = UserViewModel()
    
    var body: some View {
        NavigationStack{
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
            .navigationBarBackButtonHidden()
        }
        .fullScreenCover(isPresented: $viewModel.isSignup) {
            LoginView()
        }
    }
    
    private var InfoGroup: some View {
        VStack(spacing: 8){
            Text("계정 만들기")
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
            InputView{
                HStack{
                    if !viewModel.showPasswordCheck {
                        SecureField("비밀번호를 한 번 더 입력하세요", text: $viewModel.passwordCheck)
                        Button(action: {viewModel.showPasswordCheck.toggle()}, label: {
                            Image(.iconEyeOff)
                        })
                    } else {
                        TextField("비밀번호를 한 번 더 입력하세요", text: $viewModel.passwordCheck)
                        Button(action: {viewModel.showPasswordCheck.toggle()}, label: {
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
            Button(action: {
                viewModel.signup()
                print("회원가입")
            }, label: {
                Text("회원가입")
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
            
            NavigationLink(destination: LoginView()) {
                Text("로그인 하러 가기")
                    .font(.SMedium)
                    .foregroundStyle(.midnightDark)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(.midnightDark), lineWidth: 1)
                    )

            }
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    SignupView()
}
