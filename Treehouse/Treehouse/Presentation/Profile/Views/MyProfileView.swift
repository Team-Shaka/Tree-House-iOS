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
    
    @State private var userName: String = "username"
    @State private var userId: String = "userid"
    @State private var bio: String = "바이오입니다."
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
                                 userName: "userName",
                                 userId: "userid",
                                 bio: "바이오입니다.",
                                 branchCount: 0,
                                 treeHouseCount: 0,
                                 root: "Root",
                                 inviteAction: nil,
                                 branchAction: nil,
                                 profileAction: { viewRouter.push(ProfileRouter.editProfileView) })
                    
                    SettingView(state: .accountSetting)
                    
                    SettingView(state: .systemSetting)
                    
                    SettingView(state: .aboutTreeHouse)
                    
                    SettingView(state: .serviceSetting)
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 16)
            .navigationDestination(for: ProfileRouter.self) { router in
                viewRouter.buildScene(inputRouter: router)
            }
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
