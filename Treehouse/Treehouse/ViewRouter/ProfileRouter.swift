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
    
    case editProfileView(treehouseId: Int, memberId: Int, memberProfileUrl: String, memberName: String, bio: String)
    case memberProfileView(treehouseId: Int, memberId: Int)
    
    func buildView(_ viewModel: BaseViewModel?) -> ContentView {
        if let viewModel = viewModel as? UserInfoViewModel {
            switch self {
            case .editProfileView(let treehouseId, let memberId, let memberProfileUrl, let memberName, let bio):
                return AnyView(EditProfileView(profileUrl: memberProfileUrl, memberName: memberName, bio: bio, treehouseId: treehouseId, memberId: memberId)
                    .environment(viewModel)
                               
                )
            default:
                return AnyView(EmptyView())
            }
        } else {
            switch self {
            case .memberProfileView(let treehouseId, let memberId):
                return AnyView(MemberProfileView(treehouseId: treehouseId, memberId: memberId))
            default:
                return AnyView(EmptyView())
            }
        }
    }
}
