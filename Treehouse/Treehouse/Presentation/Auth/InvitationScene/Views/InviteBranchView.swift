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
    let phoneNumberList = UserPhoneNumberInfo.phoneNumberStructDummyData
    
    // MARK: - State Property
    
    @State var viewModel = InvitationViewModel(acceptInvitationTreeMemberUseCase: AcceptInvitationTreeMemberUseCase(repository: InvitationRepositoryImpl()),
                                                checkInvitationsUseCase: CheckInvitationsUseCase(repository: InvitationRepositoryImpl()),
                                                checkAvailableInvitationUseCase: CheckAvailableInvitationUseCase(repository: InvitationRepositoryImpl())
    )
    
    @State var phoneNumberViewModel = PhoneNumberViewModel()
    @Environment(ViewRouter.self) private var viewRouter
    
    @State private var inviteCount: Int = 0
    @State private var showPopover: Bool = false
    
    // MARK: - View
    
    var body: some View {
        @Bindable var phoneNumberViewModel = phoneNumberViewModel
        
        ScrollView() {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(StringLiterals.Invitation.sectionTitle1)
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
                                Text(StringLiterals.Invitation.buttonTitle1)
                                    .fontWithLineHeight(fontLevel: .body3)
                                    .frame(width: 82, height: 32)
                                    .foregroundStyle(.treeBlack)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(.treeBlack, lineWidth: 1.5)
                                    )
                                    .cornerRadius(16)
                            }
                        }
                        .offset(y: -44)
                    }
                    .padding(.top, 58)
                    .padding(.bottom, 15)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                    .foregroundColor(.gray3)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 9) {
                        Text(StringLiterals.Invitation.sectionTitle2)
                            .fontWithLineHeight(fontLevel: .heading4)
                            .foregroundStyle(.grayscaleBlack)
                        
                        Text("가진 초대장 : \(viewModel.availableInvitation)장")
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
                            .frame(width: CGFloat(viewModel.activeRate)/100 * SizeLiterals.Screen.screenWidth * 292/393)
                            .frame(height: 10)
                            .padding(.top, 16)
                    }
                    
                    Image("ic_invitation")
                        .offset(y: 7)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 42)
                
                HStack(spacing: 0) {
                    Text("\(100 - viewModel.activeRate)%")
                        .foregroundStyle(.treeGreen)
                    +
                    Text(StringLiterals.Invitation.guidanceTitle2)
                        .foregroundStyle(.treeBlack)
                    
                    Button(action: {
                        showPopover.toggle()
                    }, label: {
                        Image("ic_tooltip")
                    })
                    .popover(isPresented: $showPopover, attachmentAnchor: .point(.center), content: {
                        InvitationTooltip(text: StringLiterals.Invitation.tooltipTitle1, closeAction: {
                            showPopover.toggle()
                        })
                        .background(.treeDarkgreen)
                        .presentationCompactAdaptation(.popover)
                    })
                }
                .fontWithLineHeight(fontLevel: .body4)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                PhoneNumberSearchBar(text: $phoneNumberViewModel.searchText)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 14)
                    .padding(.bottom, 12)
                
                LazyVStack(spacing: 0) {
                    ForEach(phoneNumberViewModel.searchPhoneNumberList) { userData in
                        PhoneNumberRow(userInfo: userData)
                    }
                }
            }
            .padding(.horizontal, SizeLiterals.Screen.screenWidth * 16/393)
            .onTapGesture {
                hideKeyboard()
            }
            .onAppear {
                Task {
                    await viewModel.checkAvailableInvitation()
                }
            }
            .onChange(of: phoneNumberViewModel.searchText) { _, _ in
                Task {
                    await phoneNumberViewModel.searchData()
                }
            }
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        viewRouter.pop()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.treeBlack)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("받은 초대장")
                        .fontWithLineHeight(fontLevel: .heading4)
                        .foregroundStyle(.treeBlack)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        InviteBranchView()
            .environment(ViewRouter())
    }
}
