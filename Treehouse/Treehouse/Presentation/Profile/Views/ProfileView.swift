//
//  ProfileView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 6/6/24.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var userName: String = "username"
    @State private var userId: String = "userid"
    @State private var bio: String = "바이오입니다."
    @State private var branchCount: Int = 0
    @State private var treeHouseCount: Int = 0
    @State private var root: String = "Root"
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                Image(.imgUser)
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
            
            Button {} label: {
                Text(StringLiterals.Profile.editProfileLabel)
                    .font(.fontGuide(.body2))
                    .foregroundStyle(.gray1)
                    .frame(width: SizeLiterals.Screen.screenWidth * 360 / 393, height: 48)
                    .background(.treeBlack)
                    .cornerRadius(12)
            }
            .padding(.top, 26)
        }
    }
}

#Preview {
    ProfileView()
}
