//
//  ShowMemberProfileView.swift
//  Treehouse
//
//  Created by 윤영서 on 4/14/24.
//

import SwiftUI

struct ShowMemberProfileView: View {
    
    // MARK: - TODO
    // userId, bio, profileImg 서버 통신
    
    // MARK: - State Property
    
    @Environment(UserSettingViewModel.self) private var viewModel
    @Environment(ViewRouter.self) private var viewRouter
    
    @State private var userInfoViewModel = UserInfoViewModel()
    @State var isRetryButtonDisabled = false
    
    @AppStorage(Config.loginKey) private var isLogin = false
    @AppStorage("treehouseId") private var selectedTreehouseId: Int = -1
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            Text("\(StringLiterals.Register.registerTitle10)")
                .foregroundColor(.treeBlack)
                .font(.fontGuide(.heading1))
                .fontWithLineHeight(fontLevel: .heading1)
                .padding(.top, 30)
                .padding(.leading, 25)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            profileView
            
            Spacer()
            
            Button(action: {
                // MARK: - TODO
                // lottie 추가
                viewModel.isSignUp = true
                isRetryButtonDisabled = true
                
                Task {
                    switch viewModel.registerType {
                    case .registerUser:
                        let result = await viewModel.registerTreeMember()
                        
                        guard let createResult = viewModel.createUserInfoData() else { return }
                        
                        let userDataResult = await userInfoViewModel.createData(newData: createResult)
                        
                        if result && userDataResult {
                            isLogin = true
                            viewRouter.navigate(viewType: .enterTreehouse)
                        }
                    case .registerTreehouse:
                        let result = await viewModel.registerTreeMember()
                        
                        guard let createResult = viewModel.createMemberInfoData() else { return }
                        
                        let userDataResult = userInfoViewModel.addTreehouseInfo(treehouseInfo: createResult)
                        
                        if result && userDataResult {
                            isLogin = true
                            selectedTreehouseId = viewModel.treehouseId ?? 0
                            viewRouter.selectedTab = .home
                            viewRouter.navigate(viewType: .enterTreehouse)
                        }
                    }
                }
            }) {
                Text(StringLiterals.Register.buttonTitle6)
                    .frame(width: 344, height: 56)
                    .font(.fontGuide(.body2))
                    .foregroundColor(.gray1)
                    .background(.treeBlack)
                    .cornerRadius(12)
                    .padding(.horizontal, 24)
            }
            
            Button(action: {
                viewRouter.popMultiple(count: 3)
            }) {
                Text(StringLiterals.Register.buttonTitle12)
                    .fontWithLineHeight(fontLevel: .body5)
                    .foregroundStyle(.gray6)
                    .underline()
                    .padding(EdgeInsets(top: 15, leading: 17, bottom: 19, trailing: 17))
            }
            .disabled(isRetryButtonDisabled)
        }
        .onAppear {
            if viewModel.registerType == .registerTreehouse {
                viewModel.userName = userInfoViewModel.userInfo?.userName ?? ""
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .background(.grayscaleWhite)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    viewRouter.pop()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.treeBlack)
                }
                .padding(.top, 5)
            }
            ToolbarItem(placement: .principal) {
                Text(StringLiterals.Register.navigationTitle1)
                    .font(.fontGuide(.body2))
            }
        }
    }
}

// MARK: - View Builder

extension ShowMemberProfileView {
    @ViewBuilder
    var profileView: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(.gray3, lineWidth: 1)
                .padding(.top, 56)
            
            profileImageView
            
            VStack(spacing: 0) {
                VStack(spacing: 2) {
                    Text(viewModel.memberName ?? "이름 없음")
                        .fontWithLineHeight(fontLevel: .heading3)
                        .foregroundStyle(.black)
                    
                    Text("@\(viewModel.userName)")
                        .fontWithLineHeight(fontLevel: .body3)
                        .foregroundStyle(.gray5)
                }
                Text(viewModel.bio ?? "바이오 없음")
                    .font(.fontGuide(.body5))
                    .foregroundColor(.gray7)
                    .padding(.top, 22)
                    .padding(.bottom, 27)
            }
            .padding(.top, 124)
        }
        .padding(EdgeInsets(top: 48, leading: 23, bottom: 125, trailing: 24))
    }
    
    @ViewBuilder
    var profileImageView: some View {
        Circle()
            .frame(width: 112, height: 112)
        
            .overlay {
                Circle().stroke(LinearGradient(gradient: Gradient(colors: [.treeGreen, .treeBlack]),
                                               startPoint: .top,
                                               endPoint: .bottom),
                                lineWidth: 4)
                
                Circle().fill(.treePale)
                
                Image(uiImage: viewModel.profileImage, defaultImage: .imgUser1)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 99, height: 99)
                    .clipShape(Circle())
            }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ShowMemberProfileView()
            .environment(ViewRouter())
            .environment(UserSettingViewModel(checkNameUseCase: CheckNameUseCase(repository: RegisterRepositoryImpl()),
                                              registerUserUseCase: RegisterUserUseCase(repository: RegisterRepositoryImpl()),
                                              registerTreeMemberUseCase: RegisterTreeMemberUseCase(repository: RegisterRepositoryImpl()),
                                              acceptInvitationTreeMemberUseCase: AcceptInvitationTreeMemberUseCase(repository: InvitationRepositoryImpl()),
                                              checkInvitationsUseCase: CheckInvitationsUseCase(repository: InvitationRepositoryImpl()), presignedURLUseCase: PresignedURLUseCase(repository: FeedRepositoryImpl()), uploadImageToAWSUseCase: UploadImageToAWSUseCase(repository: AWSImageRepositoryImpl()), registerType: .registerUser
                                             ))
    }
}
