//
//  ReceivedFirstInvitaionView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/12/24.
//

import SwiftUI

struct ReceivedFirstInvitaionView: View {
    
    // MARK: - Property
    
    var iterater: Int {
        return viewModel.memberNum >= 3 ? 3 : viewModel.memberNum
    }

    // MARK: - State Property
    
    @Environment(UserSettingViewModel.self) private var viewModel
    @Environment(ViewRouter.self) private var viewRouter
    
    // MARK: - View
    
    var body: some View {
        ZStack(alignment: .top) {
            topHeaderView
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 24)
                .padding(.top, SizeLiterals.Screen.screenHeight * 23 / 852)
                .padding(.bottom, SizeLiterals.Screen.screenHeight * 20 / 852)
            
            ZStack(alignment: .bottom) {
                Color.clear
                
                Rectangle()
                    .fill(.treeDarkgreen)
                    .frame(height: SizeLiterals.Screen.screenHeight * 139 / 852)
                
                InvitationView(treehouseName: viewModel.treehouseName,
                               invitedMember: viewModel.invitedMember,
                               memberNum: viewModel.memberNum,
                               memberProfileUrls: viewModel.memberProfileImages,
                               invitationType: .first,
                               leftButtonAction: {
                    Task {
                        let _ = await viewModel.acceptInvitationTreeMember(acceptDecision: false)
                    }
                },
                               rightButtonAction: {
                    Task {
                        let result = await viewModel.acceptInvitationTreeMember(acceptDecision: true)
                        
                        if result {
                            viewRouter.push(RegisterRouter.setMemberProfileNameView)
                        }
                    }
                })
                .environment(viewModel)
                
                DrawingView()
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(.gray1)
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
        .task {
            await viewModel.checkInvitations()
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.gray1
            appearance.shadowColor = .clear // 하단 선 제거
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        .onDisappear {
            print("ReceivedFirstInvitationView disappeared")
        }
    }
}

// MARK: - ViewBuilder

private extension ReceivedFirstInvitaionView {
    @ViewBuilder
    var treehouseTitleView: some View {
        ZStack(alignment: .center) {
            Divider()
                .foregroundStyle(.gray3)
            
            Image(.treehouseTitle)
                .padding(EdgeInsets(top: 0, leading: 28.15, bottom: 0, trailing: 32))
                .background(.grayscaleWhite)
        }
    }
    
    @ViewBuilder
    var topHeaderView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(StringLiterals.Register.registerTitle5)
                .fontWithLineHeight(fontLevel: .heading1)
                .foregroundStyle(.black)
                .padding(.bottom, SizeLiterals.Screen.screenHeight * 24 / 852)
            
            Text(StringLiterals.Register.guidanceTitle5)
                .fontWithLineHeight(fontLevel: .body3)
                .foregroundStyle(.gray5)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ReceivedFirstInvitaionView()
            .environment(ViewRouter())
            .environment(UserSettingViewModel(checkNameUseCase: CheckNameUseCase(repository: RegisterRepositoryImpl()),
                                              registerUserUseCase: RegisterUserUseCase(repository: RegisterRepositoryImpl()),
                                              registerTreeMemberUseCase: RegisterTreeMemberUseCase(repository: RegisterRepositoryImpl()),
                                              acceptInvitationTreeMemberUseCase: AcceptInvitationTreeMemberUseCase(repository: InvitationRepositoryImpl()),
                                              checkInvitationsUseCase: CheckInvitationsUseCase(repository: InvitationRepositoryImpl()), presignedURLUseCase: PresignedURLUseCase(repository: FeedRepositoryImpl()), uploadImageToAWSUseCase: UploadImageToAWSUseCase(repository: AWSImageRepositoryImpl()), registerType: .registerUser
                                             ))
    }
}
