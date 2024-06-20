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

enum ViewType {
    case userAuthentication
    case enterTreehouse
}

@Observable
final class ViewRouter: RouterAction {
    
    private(set) var currentView: ViewType = .userAuthentication
    
    var path = NavigationPath() {
        didSet {
            print(self.path.count)
        }
    }
    
    func push(_ router: any Router) {
        print("router: \(router)")
        path.append(router)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popMultiple(count: Int) {
        guard count > 0 else { return }
        let removeCount = min(count, path.count)
        path.removeLast(removeCount)
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func navigate(viewType: ViewType) {
        currentView = viewType
        setNavigationStack(NavigationPath()) // 화면 전환 시 NavigationPath를 초기화
    }
    
    private func setNavigationStack(_ newPath: NavigationPath) {
        path = newPath
    }
    
    @ViewBuilder
    func buildScene<RouterType: Router, ViewModelType: BaseViewModel>(inputRouter: RouterType, viewModel: ViewModelType?) -> some View {
        inputRouter.buildView(viewModel)
    }
}
