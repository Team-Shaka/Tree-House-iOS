//
//  InvitationAlertView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 4/18/24.
//

import SwiftUI

struct InvitationAlertView: View {
    
    // MARK: - Property
    
    var invitationType: InvitationType
    
    var treehouseName: String
    var invitedMember: String
    var memberNum: Int
    var memberProfileUrls: [String?]
    
    var leftButtonAction: (() -> ())?
    var rightButtonAction: (() -> ())?
    var cancelButtonAction: (() -> ())?
    
    // MARK: - State Property
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var userSettingViewModel = UserSettingViewModel(checkNameUseCase: CheckNameUseCase(repository: RegisterRepositoryImpl()),
                                                       registerUserUseCase: RegisterUserUseCase(repository: RegisterRepositoryImpl()),
                                                       registerTreeMemberUseCase: RegisterTreeMemberUseCase(repository: RegisterRepositoryImpl()),
                                                       acceptInvitationTreeMemberUseCase: AcceptInvitationTreeMemberUseCase(repository: InvitationRepositoryImpl()),
                                                       checkInvitationsUseCase: CheckInvitationsUseCase(repository: InvitationRepositoryImpl()),
                                                           presignedURLUseCase: PresignedURLUseCase(repository: FeedRepositoryImpl()), uploadImageToAWSUseCase: UploadImageToAWSUseCase(repository: AWSImageRepositoryImpl()), registerType: .registerTreehouse)
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            InvitationView(treehouseName: treehouseName, 
                           invitedMember: invitedMember,
                           memberNum: memberNum,
                           memberProfileUrls: memberProfileUrls,
                           invitationType: invitationType,
                           leftButtonAction: {
                                leftButtonAction?()
                           },
                           rightButtonAction: {
                                // MARK: - TODO
                               rightButtonAction?()
                           },
                           cancelButtonAction: {
                                cancelButtonAction?()
                           })
                            .frame(height: SizeLiterals.Screen.screenHeight * 420 / 852)
                            .environment(userSettingViewModel)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(.alertBackground)
    }
}

// MARK: - Preview

#Preview {
    InvitationAlertView(invitationType: .received,
                        treehouseName: "점심팟",
                        invitedMember: "Chriiii0o0",
                        memberNum: 6,
                        memberProfileUrls: [""])
}
