//
//  InvitationRouter.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/16/24.
//

import SwiftUI

enum InvitationRouter: Router {
    typealias ContentView = AnyView
    
    case inviteBranchView
    case receivedInvitationView
    
    func buildView(_ viewModel: BaseViewModel?) -> AnyView {
        
        switch self {
        case .inviteBranchView:
            return AnyView(InviteBranchView())
        case .receivedInvitationView:
            return AnyView(ReceivedInvitationView())
        default:
            return AnyView(EmptyView())
        }
    }
}
