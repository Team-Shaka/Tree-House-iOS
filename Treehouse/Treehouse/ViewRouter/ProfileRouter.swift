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
        if let viewModel = viewModel as? UserInfoViewModel {
            switch self {
            case .editProfileView:
                return AnyView(EditProfileView()
                    .environment(viewModel))
            default:
                return AnyView(EmptyView())
            }
        } else {
            switch self {
            case .memberProfileView:
                return AnyView(MemberProfileView())
            default:
                return AnyView(EmptyView())
            }
        }
    }
}
