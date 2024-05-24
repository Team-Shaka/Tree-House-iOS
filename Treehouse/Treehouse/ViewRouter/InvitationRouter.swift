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
        
        return AnyView(EmptyView())
    }
}
