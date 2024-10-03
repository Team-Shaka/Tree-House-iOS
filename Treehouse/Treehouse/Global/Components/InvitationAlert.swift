//
//  InvitationAlert.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 9/22/24.
//

import SwiftUI

enum invitationState {
    case success
    case faliure
    case duplication
}
struct InvitationAlert: View {
    
    var invitationState: invitationState
    var memberName: String
    var onCancel: () -> Void
    var onConfirm: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Image(.icInvitation)
                .resizable()
                .scaledToFit()
                .frame(width: SizeLiterals.Screen.screenWidth * 84 / 393, height: SizeLiterals.Screen.screenHeight * 84 / 852)
                .padding(.bottom, 10)
            
            invitationStateContent
        }
        .padding(EdgeInsets(top: 14.0, leading: 13.0, bottom: 14.0, trailing: 13.0))
        .background(.grayscaleWhite)
        .clipShape(RoundedRectangle(cornerRadius: 12.0))
        .padding(.horizontal, 22)
    }
    
    @ViewBuilder
    var invitationStateContent: some View {
        switch invitationState {
        case .success:
            Text("\(memberName)에게\n초대장을 보내시겠습니까?")
                .fontWithLineHeight(fontLevel: .heading4)
                .multilineTextAlignment(.center)
                .padding(.bottom, 29)
            
            HStack(spacing: 12) {
                Button(action: {
                    onCancel()
                }) {
                    Text("취소")
                        .fontWithLineHeight(fontLevel: .body3)
                        .foregroundStyle(.treeBlack)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 11)
                        .background(.grayscaleWhite)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.treeBlack, lineWidth: 1.5)
                )
                .cornerRadius(8)
                
                Button(action: {
                    onConfirm()
                }) {
                    Text("보내기")
                        .fontWithLineHeight(fontLevel: .body3)
                        .foregroundStyle(.grayscaleWhite)
                        .padding(.vertical, 11)
                        .frame(maxWidth: .infinity)
                        .background(.grayscaleBlack)
                }
                .clipShape(RoundedRectangle(cornerRadius: 8.0))
            }
        case .faliure:
            Text("사용할 수 있는 초대장이 없습니다")
                .fontWithLineHeight(fontLevel: .heading4)
                .multilineTextAlignment(.center)
                .padding(.bottom, 29)
            
            Button(action: {
                onConfirm()
            }) {
                Text("확인")
                    .fontWithLineHeight(fontLevel: .body3)
                    .foregroundStyle(.grayscaleWhite)
                    .padding(.vertical, 11)
                    .frame(maxWidth: .infinity)
                    .background(.grayscaleBlack)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            
        case .duplication:
            Text("이미 초대가 된 멤버입니다")
                .fontWithLineHeight(fontLevel: .heading4)
                .multilineTextAlignment(.center)
                .padding(.bottom, 29)
            
            Button(action: {
                onConfirm()
            }) {
                Text("확인")
                    .fontWithLineHeight(fontLevel: .body3)
                    .foregroundStyle(.grayscaleWhite)
                    .padding(.vertical, 11)
                    .frame(maxWidth: .infinity)
                    .background(.grayscaleBlack)
            }
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
        }
    }
}

#Preview {
    InvitationAlert(invitationState: .faliure, memberName: "아무개", onCancel: {}, onConfirm: {})
}
