//
//  ProfileView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 6/6/24.
//

import SwiftUI
import PopupView
import FirebaseAuth

struct MyProfileView: View {
    
    // MARK: - State Property
    
    @Environment(ViewRouter.self) var viewRouter
    @Environment(UserInfoViewModel.self) var userInfoViewModel
    @Environment(CurrentTreehouseInfoViewModel.self) var currentTreehouseInfoViewModel
    @State var myProfileViewModel = MyProfileViewModel(readMyProfileInfoUseCase: ReadMyProfileInfoUseCase(repository: MemberRepositoryImpl()), deleteUserUseCase: DeleteUserUseCase(repository: RegisterRepositoryImpl()))

    @AppStorage(Config.loginKey) private var isLogin = false
    @AppStorage("treehouseId") private var selectedTreehouseId: Int = -1
    
    @State var isLoading = true
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .background(.grayscaleWhite)
                .environment(currentTreehouseInfoViewModel)
            
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        if let data = myProfileViewModel.myProfileData {
                            UserInfoView(infoType: .myProfile,
                                         treememberName: data.memberName,
                                         userName: data.userName,
                                         profileImageUrl: data.profileImageUrl,
                                         bio: data.bio,
                                         branchCount: data.closestMemberCount,
                                         treeHouseCount: data.treehouseCount,
                                         root: "\(data.fromMe)",
                                         inviteAction: nil,
                                         branchAction: nil,
                                         profileAction: {
                                viewRouter.push(
                                    ProfileRouter.editProfileView(
                                        treehouseId: currentTreehouseInfoViewModel.currentTreehouseId ?? 0,
                                        memberId: data.memberId,
                                        memberProfileUrl: data.profileImageUrl,
                                        memberName: data.memberName,
                                        bio: data.bio
                                    )
                                )
                            })
                        } else {
                            UserInfoView(infoType: .myProfile,
                                         treememberName: "",
                                         userName: "",
                                         profileImageUrl: "",
                                         bio: "",
                                         branchCount: 0,
                                         treeHouseCount: 0,
                                         root: "",
                                         inviteAction: {},
                                         branchAction: {},
                                         profileAction: {})
                                .redacted(reason: isLoading ? .placeholder : [])
                        }
                    }
                    
                    VStack(spacing: 0) {
                        SettingView(state: .aboutTreeHouse)
                        
                        SettingView(state: .serviceSetting)
                    }.environment(myProfileViewModel)
                }
                .padding(.top, 16)
            }
            .refreshable {
                myProfileViewModel.myProfileData = nil
                isLoading = await myProfileViewModel.readMyProfileInfo(treehouseId: selectedTreehouseId)
            }
        }
        .fullScreenCover(isPresented: $myProfileViewModel.isWebViewPresented) {
            WebViewContainer(url: myProfileViewModel.webViewUrl)
        }
        .task {
            if myProfileViewModel.isLoadedMyProfile == false {
                isLoading = true
                myProfileViewModel.myProfileData = nil
                isLoading = await myProfileViewModel.readMyProfileInfo(treehouseId: selectedTreehouseId)
            }
        }
        .onChange(of: selectedTreehouseId) { _, newValue in
            isLoading = true
            myProfileViewModel.myProfileData = nil
            Task {
                isLoading = await myProfileViewModel.readMyProfileInfo(treehouseId: selectedTreehouseId)
            }
        }
        .fullScreenCover(isPresented: $myProfileViewModel.isPresentedAlert) {
            CustomAlertView(
                isPresented: $myProfileViewModel.isPresentedAlert,
                alertType: myProfileViewModel.presentedAlertType ?? .error,
                onCancel: { },
                onConfirm: { completion in
                    switch myProfileViewModel.presentedAlertType {
                    case .logout:
                        do {
                            try Auth.auth().signOut()
                            print("User signed out successfully")

                            userInfoViewModel.deleteMyData()
                            myProfileViewModel.deleteServerToken()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                self.isLogin.toggle()
                                viewRouter.navigate(viewType: .userAuthentication)
                                completion()
                            }
                        } catch let signOutError as NSError {
                            print("Error signing out: %@", signOutError)
                        }
                    case .deleteAccount:
                        Task {
                            await myProfileViewModel.deleteUser()
                            myProfileViewModel.deleteServerToken()
                            
                            if myProfileViewModel.isDeleteUser == true {
                                userInfoViewModel.deleteMyData()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    self.isLogin.toggle()
                                    viewRouter.navigate(viewType: .userAuthentication)
                                    completion()
                                }
                            } else {
                                completion()
                            }
                        }
                    default:
                        completion()
                    }
                }
            )
            .presentationBackground(.ultraThinMaterial)
        }
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        MyProfileView()
            .environment(ViewRouter())
            .environment(UserInfoViewModel())
            .environment(CurrentTreehouseInfoViewModel(getReadTreehouseInfoUseCase: ReadTreehouseInfoUseCase(repository: TreehouseRepositoryImpl())))
    }
}
