//
//  InvitationView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/18/24.
//

import SwiftUI

enum InvitationType {
    case first
    case received
}

struct InvitationView: View {
    
    @Environment(UserSettingViewModel.self) var viewModel
    
    // MARK: - Property
    
    var iterater: Int {
        return memberNum >= 3 ? 3 : memberNum
    }
    
    var treehouseName: String
    var invitedMember: String
    var memberNum: Int
    
    var invitationType: InvitationType
    var leftButtonAction: (() -> ())?
    var rightButtonAction: (() -> ())?
    var cancelButtonAction: (() -> ())?
    
    // MARK: - View
    
    var body: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 12.0)
                .stroke(.gray3, lineWidth: 1)
                .fill(.grayscaleWhite)
            
            VStack(spacing: 0) {
                treehouseTitleView
                    .padding(.top, invitationType == .first ? SizeLiterals.Screen.screenHeight * 26.44 / 852 : SizeLiterals.Screen.screenHeight * 15 / 852)
                
                invitationView
                    .padding(.bottom, SizeLiterals.Screen.screenHeight * (46)/852)
                
                HStack(spacing: 12) {
                    Button(action: {
                        leftButtonAction?()
                    }) {
                        Text(StringLiterals.Register.buttonTitle7)
                            .fontWithLineHeight(fontLevel: .body3)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .foregroundStyle(invitationType == .first ? .gray5 : .treeBlack)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(invitationType == .first ? .gray5 : .treeBlack, lineWidth: 1.5)
                            )
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        rightButtonAction?()
                    }) {
                        Text(StringLiterals.Register.buttonTitle8)
                            .fontWithLineHeight(fontLevel: .body3)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .foregroundStyle(.white)
                            .background(.treeBlack)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, invitationType == .first ? 14 : 18)
            }
        }
        .padding(.horizontal, invitationType == .first ? 20 : 16)
        .frame(height: invitationType == .first ? SizeLiterals.Screen.screenHeight * 564 / 852 : SizeLiterals.Screen.screenHeight * 420 / 852)
    }
}

// MARK: - ViewBuilder

extension InvitationView {
    @ViewBuilder
    var treehouseTitleView: some View {
        if invitationType == .first {
            ZStack(alignment: .center) {
                Divider()
                    .foregroundStyle(.gray3)
                
                Image(.treehouseTitle)
                    .padding(EdgeInsets(top: 0, leading: 28.15, bottom: 0, trailing: 32))
                    .background(.grayscaleWhite)
            }
            .padding(.horizontal, 21)
        } else if invitationType == .received {
            HStack(alignment: .bottom) {
                Image(.treehouseTitle)
                    .padding(EdgeInsets(top: 0, leading: 138.15, bottom: 0, trailing: 85))
                
                Button(action: {
                    cancelButtonAction?()
                }) {
                    Image(systemName: "xmark")
                        .foregroundStyle(.gray5)
                }
                .frame(width: 32, height: 32)
            }
            .padding(.trailing, 17)
        }
    }
    
    @ViewBuilder
    var invitationView: some View {
        VStack(spacing: 0) {
            CustomAsyncImage(url: viewModel.senderProfileImageUrl,
                             type: .treehouseImage,
                             width: 98.56, height: 98.56)
            .clipShape(Circle())
            .padding(.top, SizeLiterals.Screen.screenHeight * 27.27 / 852)
            .padding(.bottom, SizeLiterals.Screen.screenHeight * 20.72 / 852)
            
            Text(treehouseName)
                .fontWithLineHeight(fontLevel: .heading2)
                .foregroundStyle(.treeBlack)
                .padding(.bottom, 6)
            
            HStack(spacing: 0) {
                Text("\(invitedMember)님")
                    .fontWithLineHeight(fontLevel: .body2)
                Text("이 당신을 초대했습니다.")
                    .fontWithLineHeight(fontLevel: .body3)
            }
            .foregroundStyle(.gray8)
            .padding(.bottom, 18)
            
            HStack(spacing: 0) {
                HStack(spacing: -3) {
                    ForEach(0..<iterater, id: \.self) { index in
                        memberProfileImage(index, memberNum - 2)
                    }
                }
                .padding(.trailing, 8)
                
                Text("\(memberNum)명의 멤버들이 함께하고 있어요.")
                    .fontWithLineHeight(fontLevel: .body5)
            }
        }
    }

    @ViewBuilder
    func memberProfileImage(_ index: Int, _ count: Int) -> some View {
        if index == 2 {
            ZStack(alignment: .center) {
                Circle()
                    .fill(.treeGreen)
                    .stroke(.grayscaleWhite, lineWidth: 1.5)
                    .frame(width: 29, height: 29)
                
                Text("+\(count)")
                    .fontWithLineHeight(fontLevel: .caption2)
                    .foregroundStyle(.grayscaleWhite)
            }
        } else {
            CustomAsyncImage(url: viewModel.memberProfileImages[index] ?? "",
                             type: .postMemberProfileImage,
                             width: 29, height: 29)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.grayscaleWhite, lineWidth: 1.5)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    InvitationView(treehouseName: "점심팟",
                   invitedMember: "Chriiii0o0",
                   memberNum: 6,
                   invitationType: .first)
}
