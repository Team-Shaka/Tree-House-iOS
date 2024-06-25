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
    case memberProfileView
    
    func buildView(_ viewModel: BaseViewModel?) -> ContentView {
        switch self {
        case .editProfileView:
            return AnyView(EditProfileView())
        case .memberProfileView:
            return AnyView(MemberProfileView())
        }
    }
}
