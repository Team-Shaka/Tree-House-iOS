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
    
    @Environment(ViewRouter.self) var viewRouter
    @Environment(UserInfoViewModel.self) var userInfoViewModel
    @Environment(CurrentTreehouseInfoViewModel.self) var currentTreehouseInfoViewModel
    @State var myProfileViewModel = MyProfileViewModel(readMyProfileInfoUseCase: ReadMyProfileInfoUseCase(repository: MemberRepositoryImpl()))

    @State var isPresent = false
    @State var isloading = true
    
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
                    }
                    
                    SettingView(state: .accountSetting)
                    
                    SettingView(state: .systemSetting)
                    
                    SettingView(state: .aboutTreeHouse)
                    
                    SettingView(state: .serviceSetting)
                }
                .padding(.top, 16)
            }
            .refreshable {
                if let treehouseId = currentTreehouseInfoViewModel.currentTreehouseId {
                    myProfileViewModel.isLoadedMyProfile = await myProfileViewModel.readMyProfileInfo(treehouseId: treehouseId)
                }
            }
            .padding(.bottom, 16)
        }
        .task {
            if myProfileViewModel.isLoadedMyProfile == false {
                if let treehouseId = currentTreehouseInfoViewModel.currentTreehouseId {
                    myProfileViewModel.isLoadedMyProfile = await myProfileViewModel.readMyProfileInfo(treehouseId: treehouseId)
                    
                    isloading = false
                }
            }
        }
        .redacted(reason: isloading ? .placeholder : [])
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        MyProfileView()
            .environment(ViewRouter())
    }
}
