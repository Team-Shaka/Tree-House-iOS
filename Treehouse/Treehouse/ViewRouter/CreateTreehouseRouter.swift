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
        let viewModel = DIContainer.shared.getViewModel(for: "CreateTreehouseRouter") {
            CreateTreehouseViewModel(
                checkTreehouseNameUseCase: CheckTreehouseNameUseCase(repository: TreehouseRepositoryImpl()),
                createTreehouseUseCase: CreateTreehouseUseCase(repository: TreehouseRepositoryImpl()))
                }
        
        switch self {
        case .createTreehouseNameView:
            return AnyView(CreateTreehouseNameView()
                .environment(viewModel))
        case .createTreeHallNameView:
            return AnyView(CreateTreeHallNameView()
                .environment(viewModel))
        case .previewCreatedTreehouseView:
            return AnyView(PreviewCreatedTreehouseView()
                .environment(viewModel))
        case .sendInvitationView:
            return AnyView(SendInvitationView()
                .environment(viewModel))
        }
    }
}
