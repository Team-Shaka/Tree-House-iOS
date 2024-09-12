//
//  InvitationTreehouseView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 9/11/24.
//

import SwiftUI

struct InvitationTreehouseView: View {
    
    // MARK: - State Property
    
    @Environment(MemberProfileViewModel.self) var memberProfileViewModel
    @State private var userInfoViewModel = UserInfoViewModel()
    @State var invitationTreehouseViewModel = InvitationTreehouseViewModel(readMyTreehouseInfoUseCase: ReadMyTreehouseInfoUseCase(repository: TreehouseRepositoryImpl()),
                                                                           checkAvailableInvitationUseCase: CheckAvailableInvitationUseCase(repository: InvitationRepositoryImpl()),
                                                                           invitationUseCase: InvitationUseCase(repository: InvitationRepositoryImpl()))
    @AppStorage("treehouseId") private var selectedTreehouseId: Int = -1
    
    @Binding var showSheet: Bool

    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Capsule()
                .fill(.gray4)
                .frame(width: SizeLiterals.Screen.screenWidth * 50 / 393, height: 4, alignment: .center)
                .padding(.bottom, 24)
                .frame(maxWidth: .infinity, alignment: .center)
            
            memberTitleView
                .padding(.bottom, SizeLiterals.Screen.screenHeight * 24 / 852)
            
            invitationSectionView
                .padding(.bottom, SizeLiterals.Screen.screenHeight * 9 / 852)
            
            HStack(spacing: 27) {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.gray2)
                        .frame(width: SizeLiterals.Screen.screenWidth * 292/393)
                        .frame(height: 10)
                    
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.treeBlack)
                        .frame(width: CGFloat(invitationTreehouseViewModel.activeRate)/100 * SizeLiterals.Screen.screenWidth * 292/393)
                        .frame(height: 10)
                }
                
                Image(.icInvitation)
            }
            .padding(.bottom, 28)
                
            Text(StringLiterals.MemberProfile.bottomSheetLabel2)
                .fontWithLineHeight(fontLevel: .heading4)
                .foregroundStyle(.treeBlack)
                .padding(.bottom, 14)
            
            List(invitationTreehouseViewModel.treehouseInfo ?? []) { data in
                Button(action: {
                    invitationTreehouseViewModel.invitationTreehouseTapped(treehouseId: data.treehouseId)
                }) {
                    TreehouseInfoRow(treehouseImageUrl: data.treehouseImageUrl ?? "",
                                     treehouseName: data.treehouseName,
                                     treehouseSize: data.treehouseSize,
                                     currentTreeHouse: data.currentTreeHouse
                    )
                }
                .buttonStyle(PlainButtonStyle())
                .listRowInsets(EdgeInsets(top: 7, leading: 2, bottom: 7, trailing: 2))
                .listRowSeparator(.hidden)
            }
            .listStyle(PlainListStyle())
            
            Button(action: {
                Task {
                    await invitationTreehouseViewModel.invitationTreehouse()
                    
                    await MainActor.run {
                        if invitationTreehouseViewModel.invitationResult == true {
                            showSheet.toggle()
                        }
                    }
                }
            }) {
                Text(StringLiterals.Invitation.buttonTitle2)
                    .fontWithLineHeight(fontLevel: .body2)
                    .foregroundStyle(invitationTreehouseViewModel.isSelectTreehouse ? .grayscaleWhite : .gray6)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(invitationTreehouseViewModel.isSelectTreehouse ? .grayscaleBlack : .gray2)
                    .cornerRadius(10)
            }
        }
        .padding(.top, 10)
        .padding(.horizontal, 16)
        .padding(.bottom, 29)
        .task {
            await invitationTreehouseViewModel.performAsyncTasks(currentTreehouseId: selectedTreehouseId)
        }
        .onAppear {
            invitationTreehouseViewModel.senderId = userInfoViewModel.userInfo?.findTreehouse(id: selectedTreehouseId)?.treehouseMemberId
            
            invitationTreehouseViewModel.memberPhoenNumber = memberProfileViewModel.memberProfileData?.phone
        }
    }
}

extension InvitationTreehouseView {
    @ViewBuilder
    var memberTitleView: some View {
        HStack(spacing: 0) {
            CustomAsyncImage(url: memberProfileViewModel.memberProfileData?.profileImageUrl ?? "",
                             type: .postMemberProfileImage,
                             width: 36,
                             height: 36)
            .clipShape(Circle())
            .padding(.trailing, 10)
            
            Text(memberProfileViewModel.memberProfileData?.memberName ?? "")
                .fontWithLineHeight(fontLevel: .body2)
                .foregroundStyle(.treeBlack)
                .padding(.trailing, 6)
            
            Text("초대하기")
                .fontWithLineHeight(fontLevel: .body3)
                .foregroundStyle(.treeBlack)
        }
    }
    
    @ViewBuilder
    var invitationSectionView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("가진 초대장 : \(invitationTreehouseViewModel.availableInvitation)개")
                .fontWithLineHeight(fontLevel: .heading4)
                .foregroundStyle(.treeBlack)
                .padding(.bottom, 6)
            
            Text(StringLiterals.Invitation.guidanceTitle1)
                .fontWithLineHeight(fontLevel: .body3)
                .foregroundStyle(.gray6)
        }
    }
}

#Preview {
    InvitationTreehouseView(showSheet: .constant(false))
        .environment(MemberProfileViewModel(
            readMemberInfoUseCase: ReadMemberInfoUseCase(repository: MemberRepositoryImpl()),
            readMemberFeedUseCase: ReadMemberFeedUseCase(repository: MemberRepositoryImpl()),
            treehouseId: 0,
            memberId: 0
        ))
}
