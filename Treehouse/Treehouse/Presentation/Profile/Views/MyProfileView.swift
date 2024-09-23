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
    
    @State var isPresent = false
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
        .customAlert(alertType: myProfileViewModel.isAlert.1,
                     isPresented: $myProfileViewModel.isAlert.0,
                     onCancel: { myProfileViewModel.isAlert.0.toggle() },
                     onConfirm: { switch myProfileViewModel.isAlert.1 {
                     case .logout:
                         self.isLogin.toggle()
                         userInfoViewModel.deleteMyData()
                         
                         do {
                             try Auth.auth().signOut()
                             print("User signed out successfully")
                             // 필요한 경우, 앱 내에서 상태 초기화나 화면 전환 등을 처리
                         } catch let signOutError as NSError {
                             print("Error signing out: %@", signOutError)
                         }
                         
                         DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                             viewRouter.navigate(viewType: .userAuthentication)
                             viewRouter.selectedTab = .home
                             self.isLogin.toggle()
                         }
                     case .deleteAccount:
                         self.isLogin.toggle()
                         
                         Task {
                             await myProfileViewModel.deleteUser()
                         }
                         
                         if myProfileViewModel.isDeleteUser == true {
                             userInfoViewModel.deleteMyData()
                             DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                 viewRouter.navigate(viewType: .userAuthentication)
                             }
                         }
                     } })
        .fullScreenCover(isPresented: $myProfileViewModel.isWebViewPresented) {
            WebViewContainer(url: myProfileViewModel.webViewUrl)
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
