//
//  ReceivedInvitationView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/17/24.
//

import SwiftUI

enum ReceivedInvitationViewStateType {
    case loading
    case unInvitation
    case invitation
}

struct ReceivedInvitationView: View {
    
    // MARK: - Property
    
    @Environment(ViewRouter.self) private var viewRouter
    @State private var overlayWindow: UIWindow?
    @State var viewModel = ReceivedInvitationViewModel(checkInvitationsUseCase: CheckInvitationsUseCase(repository: InvitationRepositoryImpl()), acceptInvitationTreeMemberUseCase: AcceptInvitationTreeMemberUseCase(repository: InvitationRepositoryImpl()))
    
    @State var userSettingViewModel = UserSettingViewModel(checkNameUseCase: CheckNameUseCase(repository: RegisterRepositoryImpl()),
                                                       registerUserUseCase: RegisterUserUseCase(repository: RegisterRepositoryImpl()),
                                                       registerTreeMemberUseCase: RegisterTreeMemberUseCase(repository: RegisterRepositoryImpl()),
                                                       acceptInvitationTreeMemberUseCase: AcceptInvitationTreeMemberUseCase(repository: InvitationRepositoryImpl()),
                                                       checkInvitationsUseCase: CheckInvitationsUseCase(repository: InvitationRepositoryImpl()),
                                                           presignedURLUseCase: PresignedURLUseCase(repository: FeedRepositoryImpl()), uploadImageToAWSUseCase: UploadImageToAWSUseCase(repository: AWSImageRepositoryImpl()), registerType: .registerTreehouse)
    
    // MARK: - View
    
    var body: some View {
        VStack {
            contentView(viewState: viewModel.viewState)
                .padding(.top, 14)
                .background(.grayscaleWhite)
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
        .onAppear {
            Task {
                await viewModel.checkInvitations()
            }
        }
        .onChange(of: viewModel.presentAlert) { _, newValue in
            if newValue, let tapInvitationData = viewModel.tapInvitationData {
                showOverlay(with: tapInvitationData)
            } else {
                hideOverlay()
            }
        }
        .navigationDestination(for: RegisterRouter.self) { router in
            viewRouter.buildScene(inputRouter: router, viewModel: userSettingViewModel)
        }
    }
    
    private func showOverlay(with data: CheckInvitationsDataReponseEntity) {
        let overlayVC = UIHostingController(rootView: OverlayWindowView(isPresented: $viewModel.presentAlert, tapInvitationData: data, leftButtonAction: {
            Task {
                let result = await viewModel.acceptInvitationTreeMember(acceptDecision: false)
                
                if result {
                    viewModel.presentAlert = false
                }
            }
        }, rightButtonAction: {
            Task {
                let result = await viewModel.acceptInvitationTreeMember(acceptDecision: true)
                userSettingViewModel.treehouseId = viewModel.tapInvitationData?.treehouseId
                
                await MainActor.run {
                    if result {
                        viewModel.presentAlert = false
                        viewRouter.push(RegisterRouter.setMemberProfileNameView)
                    }
                }
            }
        }))
        overlayVC.view.backgroundColor = .clear
        
        let window = UIWindow(windowScene: UIApplication.shared.connectedScenes.first as! UIWindowScene)
        window.rootViewController = overlayVC
        window.isHidden = false
        self.overlayWindow = window
    }
        
    private func hideOverlay() {
        overlayWindow?.isHidden = true
        overlayWindow = nil
    }
}

// MARK: - ViewBuilder

private extension ReceivedInvitationView {
    @ViewBuilder
    func contentView(viewState: ReceivedInvitationViewStateType) -> some View {
        switch viewState {
        case .loading:
            EmptyView()
        case .unInvitation:
            EmptyReceivedInvitationView
        case .invitation:
            ReceivedInvitationView
        }
    }
    
    @ViewBuilder
    var EmptyReceivedInvitationView: some View {
        VStack(spacing: 12) {
            Spacer(minLength: SizeLiterals.Screen.screenHeight * 246 / 852)
            
            Image(.imgInvitationempty)
            
            Text("아직 받은 초대장이 없어요")
                .fontWithLineHeight(fontLevel: .heading4)
                .foregroundStyle(.gray5)
            
            Spacer(minLength: SizeLiterals.Screen.screenHeight * 327 / 852)
        }
    }
    
    @ViewBuilder
    var ReceivedInvitationView: some View {
        List {
            ForEach(viewModel.receivedInvitations) { data in
                ReceivedInvitationRowView(image: data.senderProfileImageUrl ?? "",
                                          title: data.treehouseName,
                                          count: data.treehouseSize)
                .onTapGesture(perform: {
                    viewModel.tapInvitationData = data
                    viewModel.presentAlert.toggle()
                    print(data.treehouseName)
                })
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .background(.grayscaleWhite)
        .scrollContentBackground(.hidden)
    }
}

// MARK: - Preview

#Preview {
    ReceivedInvitationView()
}

struct OverlayWindowView: View {
    @Binding var isPresented: Bool
    let tapInvitationData: CheckInvitationsDataReponseEntity
    var leftButtonAction: (() -> ())
    var rightButtonAction: (() -> ())
    
    var body: some View {
        InvitationAlertView(
            invitationType: .received,
            treehouseName: tapInvitationData.treehouseName,
            invitedMember: tapInvitationData.senderName,
            memberNum: tapInvitationData.treehouseSize,
            memberProfileUrls: tapInvitationData.treehouseMemberProfileImages,
            leftButtonAction: {
                leftButtonAction()
            },
            rightButtonAction: {
                rightButtonAction()
            },
            cancelButtonAction: {
                isPresented = false
            }
        )
        .edgesIgnoringSafeArea(.all)
    }
}
