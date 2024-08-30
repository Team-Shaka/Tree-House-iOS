//
//  SendInvitationView.swift
//  Treehouse
//
//  Created by 윤영서 on 6/24/24.
//

import SwiftUI

struct SendInvitationView: View {
    
    // MARK: - State Property
    
    @Environment(ViewRouter.self) var viewRouter
    @Environment(CreateTreehouseViewModel.self) var createTreehouseViewModel
    
    @State var viewModel = InvitationViewModel(acceptInvitationTreeMemberUseCase: AcceptInvitationTreeMemberUseCase(repository: InvitationRepositoryImpl()),
                                               checkInvitationsUseCase: CheckInvitationsUseCase(repository: InvitationRepositoryImpl()),
                                               checkAvailableInvitationUseCase: CheckAvailableInvitationUseCase(repository: InvitationRepositoryImpl()), invitationUseCase: InvitationUseCase(repository: InvitationRepositoryImpl()))
    
    @State private var userInfoViewModel = UserInfoViewModel()
    @State var phoneNumberViewModel = PhoneNumberViewModel()
    
    @State var userSettingViewModel = UserSettingViewModel(checkNameUseCase: CheckNameUseCase(repository: RegisterRepositoryImpl()),
                                                       registerUserUseCase: RegisterUserUseCase(repository: RegisterRepositoryImpl()),
                                                       registerTreeMemberUseCase: RegisterTreeMemberUseCase(repository: RegisterRepositoryImpl()),
                                                       acceptInvitationTreeMemberUseCase: AcceptInvitationTreeMemberUseCase(repository: InvitationRepositoryImpl()),
                                                       checkInvitationsUseCase: CheckInvitationsUseCase(repository: InvitationRepositoryImpl()),
                                                           presignedURLUseCase: PresignedURLUseCase(repository: FeedRepositoryImpl()), uploadImageToAWSUseCase: UploadImageToAWSUseCase(repository: AWSImageRepositoryImpl()), registerType: .registerTreehouse)
    
    @AppStorage("treehouseId") private var selectedTreehouseId = -1
    @State private var inviteCount: Int = 0
    @State private var searchText: String = ""
    @State private var showPopover: Bool = false
    
    // MARK: - View
    
    var body: some View {
        VStack {
            ProgressView(value: 1.0)
                .tint(.treeGreen)
                .padding(.top, 14)
            
            VStack(spacing: 0) {
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
                
                getInvitationProgressView
                
                getInvitationToolTipView
                
                PhoneNumberSearchBar(text: $searchText)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 14)
                    .padding(.bottom, 12)
                
                ScrollView(.vertical) {
                    if phoneNumberViewModel.isLoading {
                        VStack {
                            Spacer()
                            
                            LottieView(lottieFile: "treehouse_loading", speed: 1)
                                .frame(width: 100, height: 100)
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.grayscaleWhite)
                        
                    } else if searchText.isEmpty {
                        ForEach(phoneNumberViewModel.phoneNumberList) { userData in
                            let treehouseInfo = userInfoViewModel.userInfo?.findTreehouse(id: selectedTreehouseId)
                            
                            PhoneNumberRow(profileImage: userData.profileImage,
                                           userName: userData.name,
                                           phoneNumber: userData.phoneNumber,
                                           isInvitation: userData.isInvitation,
                                           invitationButtonTappeed: {
                                Task {
                                    await viewModel.invitationTreehouse(senderId: treehouseInfo?.treehouseMemberId ?? 0, phoneNumber: userData.phoneNumber, treehouseId: createTreehouseViewModel.treehouseId)
                                }
                            })
                        }
                    } else {
                        ForEach(phoneNumberViewModel.phoneNumberList.filter {
                            $0.name.contains(searchText) || $0.phoneNumber.contains(searchText)
                        }) { userData in
                            let treehouseInfo = userInfoViewModel.userInfo?.findTreehouse(id: selectedTreehouseId)
                            
                            PhoneNumberRow(profileImage: userData.profileImage,
                                           userName: userData.name,
                                           phoneNumber: userData.phoneNumber,
                                           isInvitation: userData.isInvitation,
                                           invitationButtonTappeed: {
                                Task {
                                    await viewModel.invitationTreehouse(senderId: treehouseInfo?.treehouseMemberId ?? 0, phoneNumber: userData.phoneNumber, treehouseId: createTreehouseViewModel.treehouseId)
                                }
                            })
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            Button(action: {
                viewRouter.push(RegisterRouter.setMemberProfileNameView)
            }) {
                Text("다 초대했어요")
                    .fontWithLineHeight(fontLevel: .body2)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .foregroundStyle(.grayscaleWhite)
                    .background(.grayscaleBlack)
                    .cornerRadius(10)
            }
            .padding(.leading, 8)
            .padding(.trailing, 9)
            
            Button(action: {
                viewRouter.push(RegisterRouter.setMemberProfileNameView)
            }) {
                Text("지금은 건너뛸래요")
                    .fontWithLineHeight(fontLevel: .body2)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .foregroundStyle(.gray5)
                    .background(.grayscaleWhite)
                    .cornerRadius(10)
            }
            .padding(.leading, 8)
            .padding(.trailing, 9)
            
            .onTapGesture {
                UIApplication.shared.hideKeyboard()
            }
            .onAppear {
                Task {
                    await viewModel.checkAvailableInvitation()
                }
                
                userSettingViewModel.treehouseId = createTreehouseViewModel.treehouseId
                userSettingViewModel.userName = userInfoViewModel.userInfo?.userName ?? ""
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
                    Text("트리하우스 만들기")
                        .fontWithLineHeight(fontLevel: .body2)
                        .foregroundStyle(.treeBlack)
                }
            }
            .navigationDestination(for: RegisterRouter.self) { router in
                viewRouter.buildScene(inputRouter: router, viewModel: userSettingViewModel)
            }
        }
        .padding(.horizontal, SizeLiterals.Screen.screenWidth * 16/393)
    }
}

extension SendInvitationView {
    @ViewBuilder
    var getInvitationProgressView: some View {
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
    }
    
    @ViewBuilder
    var getInvitationToolTipView: some View {
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
    }
}

// MARK: - Preview

//#Preview {
//    SendInvitationView(createTreehouseViewModel: CreateTreehouseViewModel(createTreehouseUseCase: CreateTreehouseUseCase(repository: TreehouseRepositoryImpl()), treehouseName: "treehouseName"))
//}
