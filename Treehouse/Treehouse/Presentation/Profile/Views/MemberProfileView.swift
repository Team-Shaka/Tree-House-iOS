//
//  MemberProfileView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 6/10/24.
//

import SwiftUI

struct MemberProfileView: View {
    
    // MARK: - Property
    
    let groupList = MemberGroupStruct.memberGroupStructDummyData
    let availableInvitaion = AvailableInvitationStruct.availableInvitationDummyData
    
    // MARK: - State Property
    @Environment(ViewRouter.self) var viewRouter: ViewRouter
    
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
                UserInfoView(infoType: .memberProfile,
                             userName: "memberName",
                             userId: "memberid",
                             bio: "멤버 바이오입니다.",
                             branchCount: 0,
                             treeHouseCount: 0,
                             root: "Root",
                             inviteAction: nil,
                             branchAction: nil,
                             profileAction: nil)
            }
        }
        .padding(.top, 15)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    viewRouter.pop()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.grayscaleBlack)
                        
                        Text(userName)
                            .fontWithLineHeight(fontLevel: .heading4)
                            .foregroundStyle(.grayscaleBlack)
                    }
                }
                .padding(.top, 5)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        MemberProfileView()
            .environment(ViewRouter())
    }
}

