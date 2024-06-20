//
//  ProfileRouter.swift
//  Treehouse
//
//  Created by 티모시 킴 on 6/14/24.
//

import SwiftUI
import Observation

enum ProfileRouter: Router {
    typealias ContentView = AnyView
    
    case editProfileView
    
    func buildView(_ viewModel: BaseViewModel?) -> ContentView {
        switch self {
        case .editProfileView:
            return AnyView(EditProfileView())
        }
    }
}
