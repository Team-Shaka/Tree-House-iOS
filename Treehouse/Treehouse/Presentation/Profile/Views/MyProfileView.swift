//
//  ProfileView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 6/6/24.
//

import SwiftUI
import PopupView

struct MyProfileView: View {
    
    // MARK: - State Property
    
    @Environment(ViewRouter.self) var viewRouter: ViewRouter
    @Environment(UserInfoViewModel.self) var userInfoViewModel: UserInfoViewModel
    
    @State private var branchCount: Int = 0
    @State private var treeHouseCount: Int = 0
    @State private var root: String = "Root"
    @State var isPresent = false
    @State private var groupName: String = "groupname"
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(groupName: groupName, isPresent: $isPresent)
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .background(.grayscaleWhite)
            
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    UserInfoView(infoType: .myProfile,
                                 treememberName: userInfoViewModel.safeUserInfo.treeMemberName,
                                 userName: userInfoViewModel.safeUserInfo.userName,
                                 profileImage: Image(uiImage: UIImage(data: userInfoViewModel.safeUserInfo.profileImageData) ?? UIImage(resource: .imgDummy)),
                                 bio: userInfoViewModel.safeUserInfo.bio,
                                 branchCount: branchCount,
                                 treeHouseCount: treeHouseCount,
                                 root: root,
                                 inviteAction: nil,
                                 branchAction: nil,
                                 profileAction: { viewRouter.push(ProfileRouter.editProfileView) })
                    
                    SettingView(state: .accountSetting)
                    
                    SettingView(state: .systemSetting)
                    
                    SettingView(state: .aboutTreeHouse)
                    
                    SettingView(state: .serviceSetting)
                }
                .padding(.top, 16)
            }
            .padding(.bottom, 16)
            // 바텀시트 표출
            .popup(isPresented: $isPresent) {
                Text("asdfasdf")
            } customize: {
                $0
                    .type(.toast)
                    .closeOnTapOutside(true)
                    .dragToDismiss(true)
                    .isOpaque(true)
                    .backgroundColor(.treeBlack.opacity(0.5))
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        MyProfileView()
            .environment(ViewRouter())
    }
}
