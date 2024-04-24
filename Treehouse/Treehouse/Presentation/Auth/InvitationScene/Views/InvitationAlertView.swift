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
    
    var leftButtonAction: (() -> ())?
    var rightButtonAction: (() -> ())?
    var cancelButtonAction: (() -> ())?
    
    // MARK: - State Property
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            InvitationView(invitationType: invitationType,
                           leftButtonAction:  {
                                leftButtonAction?()
                            }, rightButtonAction: {
                                // MARK: - TODO
                                rightButtonAction?()
                            }, cancelButtonAction: {
                                cancelButtonAction?()
                            },
                           treehouseName: treehouseName,
                           invitedMember: invitedMember,
                           memberNum: memberNum)
                            .frame(height: SizeLiterals.Screen.screenHeight * 420 / 852)
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
                        memberNum: 6)
}
