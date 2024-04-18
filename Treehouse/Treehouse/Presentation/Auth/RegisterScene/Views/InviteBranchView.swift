//
//  InviteBranchView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/16/24.
//

import SwiftUI

struct InviteBranchView: View {
    
    @State private var inviteCount: Int = 0
    @State private var availableInviteCount: Int = 0
    @State private var percent: CGFloat = 70
    
    var body: some View {
        ScrollView() {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("새로운 초대")
                        .fontWithLineHeight(fontLevel: .heading4)
                        .foregroundStyle(.grayscaleBlack)
                    
                    ZStack {
                        Rectangle()
                            .fill(.treeDarkgreen)
                            .frame(width: 361, height: 136)
                        
                        RoundedRectangle(cornerRadius: 12.0)
                            .stroke(.gray3, lineWidth: 1)
                            .fill(.grayscaleWhite)
                            .frame(width: SizeLiterals.Screen.screenWidth * 325/393, height: 165)
                            .offset(y: -25)
                        
                        LetterView()
                        
                        VStack(spacing: 13) {
                            Text("\(inviteCount)건")
                                .fontWithLineHeight(fontLevel: .heading1)
                            
                            Button(action: {
                                
                            }) {
                                Text("확인하기 >")
                                    .font(.fontGuide(.body3))
                                    .frame(width: 82, height: 32)
                                    .foregroundStyle(.treeBlack)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(.treeBlack, lineWidth: 1.5)
                                    )
                                    .cornerRadius(16)
                            }
                        }
                        .offset(y: -40)
                    }
                    .padding(.top, 58)
                    .padding(.bottom, 15)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                    .foregroundColor(.gray3)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 9) {
                        Text("초대장 보내기")
                            .fontWithLineHeight(fontLevel: .heading4)
                            .foregroundStyle(.grayscaleBlack)
                        
                        Text("가진 초대장 : \(availableInviteCount)장")
                            .fontWithLineHeight(fontLevel: .body2)
                            .foregroundStyle(.treeGreen)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 21)
                
                Text(StringLiterals.Invitation.guidanceTitle1)
                    .fontWithLineHeight(fontLevel: .body3)
                    .foregroundStyle(.gray6)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 5)
                
                HStack(spacing: 27) {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.gray2)
                            .frame(width: SizeLiterals.Screen.screenWidth * 292/393)
                            .frame(height: 10)
                            .padding(.top, 16)
                        
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.treeBlack)
                        
                            .frame(width: percent/100 * SizeLiterals.Screen.screenWidth * 292/393)
                            .frame(height: 10)
                            .padding(.top, 16)
                    }
                    
                    Image("ic_invitation")
                        .offset(y: 7)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 42)
                
                HStack(spacing: 0) {
                    Text("\(100 - Int(percent))%")
                        .foregroundStyle(.treeGreen)
                    +
                    Text("만 더 채우면 초대장 한 장을 받아요.")
                        .foregroundStyle(.treeBlack)
                    
                    Image("ic_tooltip")
                }
                .fontWithLineHeight(fontLevel: .body4)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding(.horizontal, SizeLiterals.Screen.screenWidth * 16/33)
        }
    }
}

#Preview {
    InviteBranchView()
}
