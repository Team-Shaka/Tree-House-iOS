//
//  TreeTabView.swift
//  Treehouse
//
//  Created by 윤영서 on 5/23/24.
//

import SwiftUI

struct TreeTabView: View {
    
    // MARK: - State Property
    
    @Environment(ViewRouter.self) var viewRouter: ViewRouter
    @State private var userInfoViewModel = UserInfoViewModel()
    
    // MARK: - View
    
    var body: some View {
        @Bindable var viewRouter = viewRouter
        
        NavigationStack(path: $viewRouter.path) {
            TabView {
                FeedHomeView()
                    .tabItem {
                        Label("홈", image: "ic_home")
                    }
                    .environment(userInfoViewModel)
                
                TreeTab()
                    .tabItem {
                        Label("트리", image: "ic_tree")
                    }
                
                NotificationView()
                    .tabItem {
                        Label("알림", image: "ic_noti")
                    }
                    
                MyProfileView()
                    .tabItem {
                        Label("설정", image: "ic_setting")
                    }
                    .environment(userInfoViewModel)
            }
            .fontWithLineHeight(fontLevel: .caption2)
            .tint(.treeGreen)
            .environment(viewRouter)
//            .navigationDestination(for: FeedRouter.self) { router in
//                viewRouter.buildScene(inputRouter: router)
//            }
            .navigationDestination(for: ProfileRouter.self) { router in
                switch router {
                case .editProfileView:
                    viewRouter.buildScene(inputRouter: router, viewModel: userInfoViewModel)
                case .memberProfileView:
                    viewRouter.buildScene(inputRouter: router)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    TreeTabView()
        .environment(ViewRouter())
}
