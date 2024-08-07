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
    case sendInvitationView(treehouseName: String)
    
    func buildView(_ viewModel: BaseViewModel?) -> AnyView {
        switch self {
        case .createTreehouseNameView:
            return AnyView(CreateTreehouseNameView())
        case .createTreeHallNameView:
            return AnyView(CreateTreeHallNameView())
        case .previewCreatedTreehouseView:
            return AnyView(PreviewCreatedTreehouseView())
        case .sendInvitationView(let treehouseName):
            return AnyView(SendInvitationView(createTreehouseViewModel: CreateTreehouseViewModel(createTreehouseUseCase: CreateTreehouseUseCase(repository: TreehouseRepositoryImpl()), treehouseName: treehouseName)))
        }
    }
}
