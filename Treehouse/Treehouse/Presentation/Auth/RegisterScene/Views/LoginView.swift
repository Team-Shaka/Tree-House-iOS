//
//  LoginView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/13/24.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - State Property
    
    @Environment(UserSettingViewModel.self) private var viewModel
    @Environment(ViewRouter.self) private var viewRouter
    
    @State private var userLoginViewModel: UserLoginViewModel = UserLoginViewModel(existsUserLoginUseCase: ExistsUserLoginUserCase(repository: RegisterRepositoryImpl()), readMyProfileInfoUseCase: ReadMyProfileInfoUseCase(repository: MemberRepositoryImpl()))
    @State private var userInfoViewModel: UserInfoViewModel = UserInfoViewModel()
    
    @AppStorage(Config.loginKey) private var isLogin = false
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text(StringLiterals.Register.registerTitle3)
                    .fontWithLineHeight(fontLevel: .heading1)
                    .foregroundStyle(.treeBlack)
                    .frame(width: 287, height: 108)
                
                Spacer(minLength: SizeLiterals.Screen.screenHeight * 24 / 852)
                
                Text(StringLiterals.Register.guidanceTitle2)
                    .fontWithLineHeight(fontLevel: .body1)
                    .foregroundStyle(.gray5)
                    .frame(height: 78)
            }
            .padding(.top, SizeLiterals.Screen.screenHeight * 22 / 852)
            
            Spacer(minLength: SizeLiterals.Screen.screenHeight * 306 / 852)
            
            Text(StringLiterals.Register.etcTitle1)
                .fontWithLineHeight(fontLevel: .body1)
                .foregroundStyle(.treeGreen)
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .background(.treePale)
                .cornerRadius(10)
            
            Spacer(minLength: SizeLiterals.Screen.screenHeight * 26 / 852)
            
            Button {
                // TODO: - 내 정보에 관한 데이터가 부족, Treehouse API (내 프로필 조회) 를 통해 저장 필요
                Task {
                    let result = await userLoginViewModel.userLogin(phoneNumber: viewModel.phoneNumber?.formatPhoneNumber ?? "")
                    
                    if let userResult = result {
                        let userSaveResult = await userInfoViewModel.createData(newData: userResult)
                        
                        if userLoginViewModel.isLogin && userSaveResult {
                            isLogin = true
                            viewRouter.navigate(viewType: .enterTreehouse)
                        }
                    }
                }
            } label: {
                Text("로그인")
                    .fontWithLineHeight(fontLevel: .body2)
                    .foregroundStyle(.gray1)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(.treeBlack)
                    .cornerRadius(12)
            }
        }
        .padding(.bottom, SizeLiterals.Screen.screenHeight * 30 / 852)
        .padding(.horizontal, SizeLiterals.Screen.screenWidth * 24 / 393)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    viewRouter.pop()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.treeBlack)
                }
                .padding(.top, 5)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        LoginView()
            .environment(ViewRouter())
            .environment(UserSettingViewModel(checkNameUseCase: CheckNameUseCase(repository: RegisterRepositoryImpl()),
                                              registerUserUseCase: RegisterUserUseCase(repository: RegisterRepositoryImpl()),
                                              registerTreeMemberUseCase: RegisterTreeMemberUseCase(repository: RegisterRepositoryImpl()),
                                              acceptInvitationTreeMemberUseCase: AcceptInvitationTreeMemberUseCase(repository: InvitationRepositoryImpl()),
                                              checkInvitationsUseCase: CheckInvitationsUseCase(repository: InvitationRepositoryImpl()), presignedURLUseCase: PresignedURLUseCase(repository: FeedRepositoryImpl()), uploadImageToAWSUseCase: UploadImageToAWSUseCase(repository: AWSImageRepositoryImpl()), registerType: .registerUser
                                             ))
    }
}
