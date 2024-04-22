//
//  InviteBranchView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/16/24.
//

import SwiftUI

struct InviteBranchView: View {
    
    // MARK: - Property
    
    let availableInvitaion = AvailableInvitationStruct.availableInvitationDummyData
    let phoneNumberList = PhoneNumberStruct.phoneNumberStructDummyData
    
    // MARK: - State Property
    
    @State private var inviteCount: Int = 0
    @State private var searchText: String = ""
    @State private var showPopover: Bool = false
    
    // MARK: - View
    
    var body: some View {
        ScrollView() {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("새로운 초대")
                        .fontWithLineHeight(fontLevel: .heading4)
                        .foregroundStyle(.grayscaleBlack)
                    
                    ZStack {
                        DarkGreenLetterView()
                        
                        RoundedRectangle(cornerRadius: 12.0)
                            .stroke(.gray3, lineWidth: 1)
                            .fill(.grayscaleWhite)
                            .frame(width: SizeLiterals.Screen.screenWidth * 325/393, height: 165)
                            .offset(y: -25)
                        
                        GreenLetterView()
                        
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
                        
                        Text("가진 초대장 : \(availableInvitaion.availableInvitation)장")
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
                        
                            .frame(width: CGFloat(availableInvitaion.activeRate)/100 * SizeLiterals.Screen.screenWidth * 292/393)
                            .frame(height: 10)
                            .padding(.top, 16)
                    }
                    
                    Image("ic_invitation")
                        .offset(y: 7)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 42)
                
                HStack(spacing: 0) {
                    Text("\(100 - availableInvitaion.activeRate)%")
                        .foregroundStyle(.treeGreen)
                    +
                    Text("만 더 채우면 초대장 한 장을 받아요.")
                        .foregroundStyle(.treeBlack)
                    
                    Button(action: {
                        showPopover.toggle()
                    }, label: {
                        Image("ic_tooltip")
                    })
                    .popover(isPresented: $showPopover, attachmentAnchor: .point(.center), content: {
                        InvitationTooltip(text: "게시글, 댓글 작성 등\n활발한 활동을 하면 그래프가 늘어나요!", closeAction: {
                            showPopover.toggle()
                        })
                        .background(.treePale)
                        .presentationCompactAdaptation(.popover)
                    })

                    
                }
                .fontWithLineHeight(fontLevel: .body4)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                PhoneNumberSearchBar(text: $searchText)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 14)
                    .padding(.bottom, 12)
                
                if searchText.isEmpty {
                    ForEach(phoneNumberList) { phoneNumber in
                        PhoneNumberRow(phoneNumber: phoneNumber)
                    }
                } else {
                    ForEach(phoneNumberList.filter {
                        $0.name.contains(searchText) || $0.phoneNumber.contains(searchText)
                    }) { phoneNumber in
                        PhoneNumberRow(phoneNumber: phoneNumber)
                    }
                }
            }
            .padding(.horizontal, SizeLiterals.Screen.screenWidth * 16/393)
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}

// MARK: - Preview

#Preview {
    InviteBranchView()
}
