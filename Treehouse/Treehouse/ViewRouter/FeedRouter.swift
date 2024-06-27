//
//  FeedRouter.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/21/24.
//

import SwiftUI

enum FeedRouter: Router {
    typealias ContentView = AnyView
    
    case postDetailView
    
    func buildView(_ viewModel: BaseViewModel?) -> ContentView {
        switch self {
        case .postDetailView:
            return AnyView(PostDetailView(viewModel: PostDetailViewModel()))
        }
    }
}
