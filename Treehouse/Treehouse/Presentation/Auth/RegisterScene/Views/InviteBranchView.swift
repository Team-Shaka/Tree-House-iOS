//
//  InviteBranchView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/16/24.
//

import SwiftUI

struct InviteBranchView: View {
    
    @State private var inviteCount: Int = 0
    
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
            }
            .padding(.horizontal, SizeLiterals.Screen.screenWidth * 16/33)
        }
    }
}

#Preview {
    InviteBranchView()
}
