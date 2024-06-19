//
//  UnableRegisterView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/12/24.
//

import SwiftUI

struct UnableRegisterView: View {
    
    // MARK: - State Property
    
    @Environment(UserSettingViewModel.self) private var viewModel
    @Environment(ViewRouter.self) private var viewRouter
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Image("error")
                    .frame(width: 57, height: 57)
                
                Spacer(minLength: SizeLiterals.Screen.screenHeight * 28 / 852)
                
                Text(StringLiterals.Register.registerTitle2)
                    .fontWithLineHeight(fontLevel: .heading1)
                    .foregroundStyle(.treeBlack)
                    .frame(width: 335, height: 72)
                
                Spacer(minLength: SizeLiterals.Screen.screenHeight * 24 / 852)
                
                Text(StringLiterals.Register.guidanceTitle2)
                    .fontWithLineHeight(fontLevel: .body1)
                    .foregroundStyle(.gray5)
                    .frame(height: 78)
            }
            .padding(.top, SizeLiterals.Screen.screenHeight * 60 / 852)
            
            Spacer(minLength: SizeLiterals.Screen.screenHeight * 269 / 852)
            
            Text(StringLiterals.Register.etcTitle1)
                .fontWithLineHeight(fontLevel: .body1)
                .foregroundStyle(.treeGreen)
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .background(.treePale)
                .cornerRadius(10)
            
            Spacer(minLength: SizeLiterals.Screen.screenHeight * 26 / 852)
            
            Button {
                print("돌아가기 버튼 탭했음")
            } label: {
                Text(StringLiterals.Register.buttonTitle3)
                    .font(.fontGuide(.body2))
                    .foregroundStyle(.gray1)
                    .frame(width: SizeLiterals.Screen.screenWidth * 344 / 393, height: 56)
                    .background(.treeBlack)
                    .cornerRadius(12)
            }
            .padding(.bottom, SizeLiterals.Screen.screenHeight * 30 / 852)
        }
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
        UnableRegisterView()
            .environment(ViewRouter())
            .environment(UserSettingViewModel(checkNameUseCase: CheckNameUseCase(repository: RegisterRepositoryImpl()),
                                              registerUserUseCase: RegisterUserUseCase(repository: RegisterRepositoryImpl()),
                                              registerTreeMemberUseCase: RegisterTreeMemberUseCase(repository: RegisterRepositoryImpl()),
                                              acceptInvitationTreeMemberUseCase: AcceptInvitationTreeMemberUseCase(repository: InvitationRepositoryImpl()),
                                              checkInvitationsUseCase: CheckInvitationsUseCase(repository: InvitationRepositoryImpl()),
                                              checkAvailableInvitationUseCase: CheckAvailableInvitationUseCase(repository: InvitationRepositoryImpl())
                                             ))
    }
}
