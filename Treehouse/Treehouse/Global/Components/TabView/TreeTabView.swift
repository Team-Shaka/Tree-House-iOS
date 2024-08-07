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
    @State private var currentTreehouseInfoViewModel = CurrentTreehouseInfoViewModel(getReadTreehouseInfoUseCase: ReadTreehouseInfoUseCase(repository: TreehouseRepositoryImpl()))
    
    // MARK: - View
    
    var body: some View {
        @Bindable var viewRouter = viewRouter
        
        NavigationStack(path: $viewRouter.path) {
            TabView(selection: $viewRouter.selectedTab) {
                FeedHomeView()
                    .background(.grayscaleWhite)
                    .tabItem {
                        Label("홈", image: "ic_home")
                            .fontWithLineHeight(fontLevel: .caption2)
                    }
                    .environment(userInfoViewModel)
                    .tag(TabType.home)
                
                TreeTab()
                    .tabItem {
                        Label("트리", image: "ic_tree")
                            .fontWithLineHeight(fontLevel: .caption2)
                    }
                    .tag(TabType.tree)
                
                NotificationView()
                    .tabItem {
                        Label("알림", image: "ic_noti")
                            .fontWithLineHeight(fontLevel: .caption2)
                    }
                    .tag(TabType.notice)
                
                MyProfileView()
                    .background(.grayscaleWhite)
                    .tabItem {
                        Label("설정", image: "ic_setting")
                            .fontWithLineHeight(fontLevel: .caption2)
                    }
                    .environment(userInfoViewModel)
                    .tag(TabType.setting)
            }
            .tint(.treeGreen)
            .environment(viewRouter)
            .environment(currentTreehouseInfoViewModel)
            .onAppear {
                if let currentTreehouseId = currentTreehouseInfoViewModel.currentTreehouseId {
                    Task {
                        await currentTreehouseInfoViewModel.getReadTreehouseInfo(treehouseId: currentTreehouseId)
                    }
                } else {
                    if let userInfo = userInfoViewModel.userInfo, let treehouseId = userInfo.treehouses.first {
                        currentTreehouseInfoViewModel.currentTreehouseId = treehouseId
                        currentTreehouseInfoViewModel.userId = userInfo.findTreehouse(id: treehouseId)?.treehouseMemberId ?? 0
                        
                        Task {
                            await currentTreehouseInfoViewModel.getReadTreehouseInfo(treehouseId: treehouseId)
                        }
                    }
                }
            }
            .onAppear {
                let appearance = UITabBarAppearance()
                appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
                appearance.backgroundColor = .grayscaleWhite
                
                // 스크롤 할때의 TabBar Layout
                UITabBar.appearance().standardAppearance = appearance
                // 완전히 스크롤 됐을 때 의 TabBar Layout
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}

// MARK: - Preview

#Preview {
    TreeTabView()
        .environment(ViewRouter())
}

enum TabType {
    case home
    case tree
    case notice
    case setting
}
