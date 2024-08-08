//
//  SendInvitationView.swift
//  Treehouse
//
//  Created by 윤영서 on 6/24/24.
//

import SwiftUI

struct SendInvitationView: View {
    
    // MARK: - Property
    
    let availableInvitaion = AvailableInvitationStruct.availableInvitationDummyData
//    let phoneNumberList = UserPhoneNumberInfo.phoneNumberStructDummyData
    
    // MARK: - State Property
    @Environment(ViewRouter.self) var viewRouter
    @State var createTreehouseViewModel: CreateTreehouseViewModel
    
    @State var viewModel = InvitationViewModel(acceptInvitationTreeMemberUseCase: AcceptInvitationTreeMemberUseCase(repository: InvitationRepositoryImpl()),
                                               checkInvitationsUseCase: CheckInvitationsUseCase(repository: InvitationRepositoryImpl()),
                                               checkAvailableInvitationUseCase: CheckAvailableInvitationUseCase(repository: InvitationRepositoryImpl()))
    
    @State private var userInfoViewModel = UserInfoViewModel()
    @State var phoneNumberViewModel = PhoneNumberViewModel()
    
    @AppStorage("treehouseId") private var selectedTreehouseId = -1
    @State private var inviteCount: Int = 0
    @State private var searchText: String = ""
    @State private var showPopover: Bool = false
    
    // MARK: - View
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
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
                    
                    if searchText.isEmpty {
                        ForEach(phoneNumberViewModel.phoneNumberList) { userData in
                            PhoneNumberRow(userInfo: userData)
                        }
                    } else {
                        ForEach(phoneNumberViewModel.phoneNumberList.filter {
                            $0.name.contains(searchText) || $0.phoneNumber.contains(searchText)
                        }) { userData in
                            PhoneNumberRow(userInfo: userData)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            Button(action: {
                // TODO: - 다음 뷰로 연결
                Task {
                    let result = await performAsyncTasks()
                    
                    if result {
                        viewRouter.popToRoot()
                    }
                }
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
                // TODO: - 다음 뷰로 연결
                Task {
                    let result = await performAsyncTasks()
                    
                    if result {
                        viewRouter.popToRoot()
                    }
                }
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
        }
        .padding(.horizontal, SizeLiterals.Screen.screenWidth * 16/393)
    }
    
    func performAsyncTasks() async -> Bool {
        let treehouseId = await createTreehouseViewModel.createTreehouse()
        
        if let id = treehouseId {
            let result = userInfoViewModel.modifyTreehouse(treehouseId: id)
            print("정보 저장 결과:", result)
            
            if result {
                selectedTreehouseId = id
                return true
            }
        }
        
        return false
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

#Preview {
    SendInvitationView(createTreehouseViewModel: CreateTreehouseViewModel(createTreehouseUseCase: CreateTreehouseUseCase(repository: TreehouseRepositoryImpl()), treehouseName: "treehouseName"))
}
