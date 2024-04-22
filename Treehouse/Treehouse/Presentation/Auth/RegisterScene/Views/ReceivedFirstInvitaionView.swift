//
//  ReceivedFirstInvitaionView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/12/24.
//

import SwiftUI

struct ReceivedFirstInvitaionView: View {
    
    // MARK: - Property
    
    var iterater: Int {
        return memberNum >= 3 ? 3 : memberNum
    }

    var treehouseName: String = "점심팟"
    var invitedMember: String = "Chriiii0o0"
    var memberNum: Int = 20
    
    // MARK: - View
    
    var body: some View {
        ZStack(alignment: .top) {
            topHeaderView
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 24)
                .padding(.top, SizeLiterals.Screen.screenHeight * 23 / 852)
                .padding(.bottom, SizeLiterals.Screen.screenHeight * 20 / 852)
            
            ZStack(alignment: .bottom) {
                Color.clear
                
                Rectangle()
                    .fill(.treeDarkgreen)
                    .frame(height: SizeLiterals.Screen.screenHeight * 139 / 852)
                
                InvitationView(invitationType: .first,
                               treehouseName: treehouseName,
                               invitedMember: invitedMember,
                               memberNum: memberNum)
                
                DrawingView()
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(.gray1)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .frame(width: 24, height: 24)
                }
                .padding(.top, 11)
            }
        }
    }
}

// MARK: - ViewBuilder

private extension ReceivedFirstInvitaionView {
    @ViewBuilder
    var treehouseTitleView: some View {
        ZStack(alignment: .center) {
            Divider()
                .foregroundStyle(.gray3)
            
            Image(.treehouseTitle)
                .padding(EdgeInsets(top: 0, leading: 28.15, bottom: 0, trailing: 32))
                .background(.grayscaleWhite)
        }
    }
    
    @ViewBuilder
    var invitationView: some View {
        VStack(spacing: 0) {
            Image(.imgDummy)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: SizeLiterals.Screen.screenWidth * 98.56 / 393, height: SizeLiterals.Screen.screenHeight * 98.56 / 852)
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
                    ForEach(0..<iterater) { index in
                        memberProfileImage(index, memberNum-2)
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
                
                Text("+\(memberNum-2)")
                    .fontWithLineHeight(fontLevel: .caption2)
                    .foregroundStyle(.grayscaleWhite)
            }
        } else {
            Image(.imgDummy)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: 29, height: 29)
                .overlay {
                    Circle().stroke(.grayscaleWhite, lineWidth: 1.5)
                }
        }
    }
    
    @ViewBuilder
    var topHeaderView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(StringLiterals.Register.registerTitle5)
                .fontWithLineHeight(fontLevel: .heading1)
                .foregroundStyle(.black)
                .padding(.bottom, SizeLiterals.Screen.screenHeight * 24 / 852)
            
            Text(StringLiterals.Register.guidanceTitle5)
                .fontWithLineHeight(fontLevel: .body3)
                .foregroundStyle(.gray5)
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ReceivedFirstInvitaionView()
    }
}
