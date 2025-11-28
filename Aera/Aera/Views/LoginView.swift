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
        .fullScreenCover(isPresented: $viewModel.isLogin) {
            MainView()
        }
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
        VStack(alignment: .leading, spacing: 16){
            InputView{
                TextField("아이디를 입력하세요", text: $viewModel.id)
                    .textInputAutocapitalization(.never)
            }
            
            InputView{
                HStack{
                    if !viewModel.showPassword {
                        SecureField("비밀번호를 입력하세요", text: $viewModel.password)
                            .textInputAutocapitalization(.never)
                        Button(action: {viewModel.showPassword.toggle()}, label: {
                            Image(.iconEyeOff)
                        })
                    } else {
                        TextField("비밀번호를 입력하세요", text: $viewModel.password)
                            .textInputAutocapitalization(.never)
                        Button(action: {viewModel.showPassword.toggle()}, label: {
                            Image(.iconEyeOn)
                        })
                    }
                }
            }
            
            Text(viewModel.errorMessage ?? "")
                .foregroundStyle(.red)
        }
        
        .padding(.horizontal, 24)
    }
    
    private var ButtonGroup: some View {
        VStack(spacing: 24){
            Button(action: {
                viewModel.login()
            }, label: {
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
            
            NavigationLink(destination: SignupView()) {
                Text("회원가입 하러 가기")
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
    LoginView()
}
