//
//  ViewRouter.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/13/24.
//

import Foundation
import SwiftUI
import Observation

protocol RouterAction {
    func push(_ router: any Router)
    func pop()
    func popToRoot()
}

protocol Router: Hashable {
    associatedtype ContentView: View
    func buildView(_ viewModel: BaseViewModel?) -> ContentView
}

@Observable
final class ViewRouter: RouterAction {
    var path = NavigationPath()
    
    func push(_ router: any Router) {
        print("router: \(router)")
        path.append(router)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func buildScene<RouterType: Router, ViewModelType: BaseViewModel>(inputRouter: RouterType, viewModel: ViewModelType?) -> some View {
        inputRouter.buildView(viewModel)
    }
}
