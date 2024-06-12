//
//  MemberProfileView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 6/10/24.
//

import SwiftUI

struct MemberProfileView: View {
    
    let groupList = MemberGroupStruct.memberGroupStructDummyData
    let availableInvitaion = AvailableInvitationStruct.availableInvitationDummyData
    
    @State var isPresent = false
    @State private var userName: String = "username"
    @State private var userId: String = "userid"
    @State private var bio: String = "바이오입니다."
    @State private var branchCount: Int = 0
    @State private var treeHouseCount: Int = 0
    @State private var root: String = "Root"
    @State private var selectedGroupId: UUID?
    
    var body: some View {
        ZStack {
            ScrollView() {
                VStack(spacing: 0) {
                    HStack(alignment: .top, spacing: 0) {
                        Image(.imgUser)
                            .resizable()
                            .frame(width: 80, height: 80)
                            .padding(.leading, SizeLiterals.Screen.screenWidth * 16 / 393)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            HStack(spacing: 6) {
                                Text(userName)
                                    .fontWithLineHeight(fontLevel: .heading4)
                                    .foregroundColor(.grayscaleBlack)
                                
                                Text("@\(userId)")
                                    .fontWithLineHeight(fontLevel: .body3)
                                    .foregroundColor(.gray6)
                            }
                            
                            VStack {
                                HStack {
                                    Text(bio)
                                        .fontWithLineHeight(fontLevel: .body5)
                                        .foregroundColor(.grayscaleBlack)
                                        .padding(12)
                                    Spacer()
                                }
                            }
                            .background(
                                Rectangle()
                                    .selectCornerRadius(radius: 10, corners: .topRight)
                                    .selectCornerRadius(radius: 10, corners: .bottomLeft)
                                    .selectCornerRadius(radius: 10, corners: .bottomRight)
                                    .foregroundColor(.gray2)
                            )
                        }
                        .padding(.leading, SizeLiterals.Screen.screenWidth * 12 / 393)
                        .padding(.trailing, SizeLiterals.Screen.screenWidth * 12 / 393)
                        .offset(y: -3)
                        
                        Spacer()
                    }
                    
                    HStack(spacing: 0) {
                        VStack(spacing: 6) {
                            Text("\(branchCount)명")
                                .fontWithLineHeight(fontLevel: .heading3)
                                .foregroundColor(.treeBlack)
                            
                            Text(StringLiterals.Profile.profileBranchCountTitle)
                                .fontWithLineHeight(fontLevel: .caption1)
                                .foregroundColor(.gray6)
                        }
                        .padding(.leading, SizeLiterals.Screen.screenWidth * 45 / 393)
                        
                        Spacer()
                        
                        VStack(spacing: 6) {
                            Text("\(treeHouseCount)개")
                                .fontWithLineHeight(fontLevel: .heading3)
                                .foregroundColor(.treeBlack)
                            
                            Text(StringLiterals.Profile.profileTreeHouseCountTitle)
                                .fontWithLineHeight(fontLevel: .caption1)
                                .foregroundColor(.gray6)
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 6) {
                            Text(root)
                                .fontWithLineHeight(fontLevel: .heading3)
                                .foregroundColor(.treeBlack)
                            
                            Text(StringLiterals.Profile.profileRootTitle)
                                .fontWithLineHeight(fontLevel: .caption1)
                                .foregroundColor(.gray6)
                        }
                        .padding(.trailing, SizeLiterals.Screen.screenWidth * 45 / 393)
                    }
                    .padding(.top, 10)
                    
                    HStack(spacing: SizeLiterals.Screen.screenWidth * 17 / 393) {
                        Button {} label: {
                            Text(StringLiterals.Profile.buttonLabel2)
                                .font(.fontGuide(.body2))
                                .foregroundStyle(.gray1)
                                .frame(width: SizeLiterals.Screen.screenWidth * 172 / 393, height: 48)
                                .background(.treeGreen)
                                .cornerRadius(12)
                        }
                        .padding(.top, 26)
                        
                        Button {
                            isPresent = true
                        } label: {
                            Text(StringLiterals.Profile.buttonLabel3)
                                .font(.fontGuide(.body2))
                                .foregroundStyle(.gray1)
                                .frame(width: SizeLiterals.Screen.screenWidth * 172 / 393, height: 48)
                                .background(.treeBlack)
                                .cornerRadius(12)
                        }
                        .padding(.top, 26)
                    }
                    
                    Rectangle()
                        .frame(height: 10)
                        .foregroundColor(.gray2)
                        .padding(.top, 20)
                    
                }
            }
            
            ZStack(alignment: .bottom) {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.top)
                    .opacity(isPresent ? 1 : 0)
                    .onTapGesture {
                        isPresent = false
                        selectedGroupId = nil
                    }
                
                if self.isPresent {
                    BottomSheet($isPresent, height: SizeLiterals.Screen.screenHeight * 730 / 852) {
                        VStack(spacing: 0) {
                            HStack(spacing: 0) {
                                Image(.imgUser)
                                    .resizable()
                                    .frame(width: 36, height: 36)
                                    .padding(.leading, SizeLiterals.Screen.screenWidth * 16 / 393)
                                
                                Text(userName)
                                    .fontWithLineHeight(fontLevel: .body2)
                                    .padding(.leading, 10)
                                
                                Text(StringLiterals.MemberProfile.bottomSheetLabel1)
                                    .fontWithLineHeight(fontLevel: .body3)
                                    .padding(.leading, 6)
                                
                                Spacer()
                            }
                            .padding(.top, 13)
                            
                            HStack {
                                Text("가진 초대장 : \(availableInvitaion.availableInvitation)개")
                                    .fontWithLineHeight(fontLevel: .heading4)
                                    .padding(.leading, SizeLiterals.Screen.screenWidth * 16 / 393)
                                
                                Spacer()
                            }
                            .padding(.top, 24)
                            
                            Text(StringLiterals.Invitation.guidanceTitle1)
                                .fontWithLineHeight(fontLevel: .body3)
                                .foregroundStyle(.gray6)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.top, 5)
                                .padding(.horizontal, SizeLiterals.Screen.screenWidth * 16 / 393)
                            
                            HStack(spacing: 27) {
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.gray2)
                                        .frame(width: SizeLiterals.Screen.screenWidth * 292/393)
                                        .frame(height: 10)
                                        .padding(.top, 16)
                                    
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.treeBlack)
                                        .frame(width: CGFloat(availableInvitaion.activeRate)/100 * SizeLiterals.Screen.screenWidth * 292/393)
                                        .frame(height: 10)
                                        .padding(.top, 16)
                                }
                                
                                Image("ic_invitation")
                                    .offset(y: 7)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .frame(height: 42)
                            .padding(.horizontal, SizeLiterals.Screen.screenWidth * 16 / 393)
                            
                            HStack {
                                Text(StringLiterals.MemberProfile.bottomSheetLabel2)
                                    .fontWithLineHeight(fontLevel: .heading4)
                                    .foregroundColor(.grayscaleBlack)
                                    .padding(.leading, SizeLiterals.Screen.screenWidth * 16 / 393)
                                
                                Spacer()
                            }
                            .padding(.top, 24)
                            
                            if groupList.count > (SizeLiterals.Screen.screenHeight/2 > 400 ? 3 : 2) {
                                ScrollView {
                                    ForEach(groupList) { group in
                                        MemberGroupRow(group: group, isSelected: group.id == selectedGroupId) {
                                            selectedGroupId = group.id
                                        }
                                    }
                                }
                                .scrollIndicators(.never)
                                .frame(height: SizeLiterals.Screen.screenHeight/2 > 400 ? 260 : 170)
                                .padding(.top, 14)
                            } else {
                                ForEach(groupList) { group in
                                    MemberGroupRow(group: group, isSelected: group.id == selectedGroupId) {
                                        selectedGroupId = group.id
                                    }
                                }
                                .padding(.top, 14)
                            }
                            
                            Spacer()
                            
                            Button {
                                print("탭 수행")
                            } label: {
                                Text("초대하기")
                                    .font(.fontGuide(.body2))
                                    .foregroundStyle((selectedGroupId != nil) ? .gray1 : .gray6)
                                    .frame(width: SizeLiterals.Screen.screenWidth * 360 / 393, height: 56)
                                    .background((selectedGroupId != nil) ? .treeBlack : .gray2)
                                    .cornerRadius(12)
                            }
                            .padding(.bottom, SizeLiterals.Screen.screenHeight * 64 / 852)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .animation(.interactiveSpring(), value: isPresent)
        }
    }
}

#Preview {
    MemberProfileView()
}

