//
//  UserInfoView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/23/24.
//

import SwiftUI

enum userInfoType {
    case myProfile
    case memberProfile
}

struct UserInfoView: View {

    // MARK: - Property
    
    var infoType: userInfoType
    var treememberName: String
    var userName: String
    var profileImageUrl: String
    var bio: String
    var branchCount: Int
    var treeHouseCount: Int
    var root: String
    
    var image: UIImage?
    
    // MARK: - Closure Property
    
    let inviteAction: (() -> Void)?
    let branchAction: (() -> Void)?
    let profileAction: (() -> Void)?
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                CustomAsyncImage(url: profileImageUrl,
                                 type: .postMemberProfileImage,
                                 width: 80,
                                 height: 80)
                    .clipShape(Circle())
                    .padding(.leading, SizeLiterals.Screen.screenWidth * 16 / 393)
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack(spacing: 6) {
                        Text(treememberName)
                            .fontWithLineHeight(fontLevel: .heading4)
                            .foregroundColor(.grayscaleBlack)
                        
                        Text("@\(userName)")
                            .fontWithLineHeight(fontLevel: .body3)
                            .foregroundColor(.gray6)
                    }
                    
                    VStack {
                        Text(bio)
                            .fontWithLineHeight(fontLevel: .body5)
                            .foregroundColor(.grayscaleBlack)
                            .padding(12)
                            .frame(width: SizeLiterals.Screen.screenWidth * 268 / 393, alignment: .leading)
                    }
                    .background(
                        Rectangle()
                            .selectCornerRadius(radius: 10, corners: [.topRight, .bottomLeft, .bottomRight])
                            .foregroundColor(.gray2)
                    )
                }
                .padding(.leading, SizeLiterals.Screen.screenWidth * 12 / 393)
                .padding(.trailing, SizeLiterals.Screen.screenWidth * 12 / 393)
            }
            
            treehouseInfoView
                .padding(.top, 25)
            
            infoMenuButtons
                .padding(.top, 14)
                .padding(.horizontal, 16)
            
            Rectangle()
                .frame(height: 12)
                .foregroundColor(.gray2)
                .padding(.top, 20)
        }
    }
}

// MARK: - ViewBuilders

private extension UserInfoView {
    @ViewBuilder
    var treehouseInfoView: some View {
        HStack(spacing: 0) {
            VStack(spacing: 6) {
                Text("\(branchCount)명")
                    .fontWithLineHeight(fontLevel: .heading3)
                    .foregroundColor(.treeBlack)
                
                Text(StringLiterals.Profile.profileBranchCountTitle)
                    .fontWithLineHeight(fontLevel: .caption1)
                    .foregroundColor(.gray6)
            }
            
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
        }
        .padding(.leading, SizeLiterals.Screen.screenWidth * 39 / 393)
        .padding(.trailing, SizeLiterals.Screen.screenWidth * 44 / 393)
        .padding(.vertical, 12)
    }
    
    @ViewBuilder
    var infoMenuButtons: some View {
        switch infoType {
        case .memberProfile:
            HStack(spacing: 17) {
                Button(action: {
                    branchAction?()
                }) {
                    Text(StringLiterals.Profile.buttonLabel2)
                        .font(.fontGuide(.body4))
                        .foregroundStyle(.gray1)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(.treeGreen)
                        .cornerRadius(12)
                }
                
                Button(action: {
                    inviteAction?()
                }) {
                    Text(StringLiterals.Profile.buttonLabel3)
                        .font(.fontGuide(.body4))
                        .foregroundStyle(.gray1)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(.treeBlack)
                        .cornerRadius(12)
                }
            }
        case .myProfile:
            Button(action: {
                profileAction?()
            }) {
                Text(StringLiterals.Profile.buttonLabel1)
                    .font(.fontGuide(.body4))
                    .foregroundStyle(.gray1)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(.treeBlack)
                    .cornerRadius(12)
            }
        }
    }
}

// MARK: - Preview

//#Preview {
//    UserInfoView(infoType: .memberProfile, treememberName: "", userName: "", profileImage: Image(.imgDummy), bio: "", branchCount: 0, treeHouseCount: 0, root: "", inviteAction: nil,
//                 branchAction: nil,
//                 profileAction: nil)
//}
