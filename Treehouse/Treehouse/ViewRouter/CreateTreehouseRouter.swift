//
//  CreateTreehouseRouter.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 8/1/24.
//

import Foundation
import SwiftUI

enum CreateTreehouseRouter: Router {
    typealias ContentView = AnyView
    
    case createTreehouseNameView
    case createTreeHallNameView
    case previewCreatedTreehouseView
    case sendInvitationView
    
    func buildView(_ viewModel: BaseViewModel?) -> AnyView {
        switch self {
        case .createTreehouseNameView:
            return AnyView(CreateTreehouseNameView())
        case .createTreeHallNameView:
            return AnyView(CreateTreeHallNameView())
        case .previewCreatedTreehouseView:
            return AnyView(PreviewCreatedTreehouseView())
        case .sendInvitationView:
            return AnyView(SendInvitationView())
        }
    }
}
