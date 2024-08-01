//
//  MemberProfileView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 6/10/24.
//

import SwiftUI

struct MemberProfileView: View {
    
    // MARK: - Property
    
    var treehouseId: Int
    var memberId: Int
    
    // MARK: - State Property
    @Environment(ViewRouter.self) var viewRouter: ViewRouter
    @State var memberProfileViewModel = MemberProfileViewModel(readMemberInfoUseCase: ReadMemberInfoUseCase(repository: MemberRepositoryImpl()))
    
    @State var isPresent = false
    @State private var userName: String = "username"
    @State private var userId: String = "userid"
    @State private var bio: String = "바이오입니다."
    @State private var branchCount: Int = 0
    @State private var treeHouseCount: Int = 0
    @State private var root: String = "Root"
    @State private var selectedGroupId: UUID?
    
    // MARK: - View
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 0) {
                if let data = memberProfileViewModel.memberProfileData {
                    UserInfoView(infoType: .memberProfile,
                                 treememberName: data.memberName,
                                 userName: data.userName,
                                 profileImageUrl: data.profileImageUrl,
                                 bio: data.bio,
                                 branchCount: data.closestMemberCount,
                                 treeHouseCount: data.treehouseCount,
                                 root: "\(data.fromMe)",
                                 inviteAction: nil,
                                 branchAction: nil,
                                 profileAction: nil)
                    .padding(.top, 15)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
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
            
            ToolbarItem(placement: .principal) {
                Text(memberProfileViewModel.memberProfileData?.memberName ?? "")
                    .fontWithLineHeight(fontLevel: .body2)
                    .foregroundStyle(.treeBlack)
            }
        }
        .task {
            _ = await memberProfileViewModel.readMemberInfo(treehouseId: treehouseId, memberId: memberId)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        MemberProfileView(treehouseId: 0, memberId: 0)
            .environment(ViewRouter())
    }
}

