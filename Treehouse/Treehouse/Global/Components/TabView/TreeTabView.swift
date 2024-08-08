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
            TabView {
                FeedHomeView()
                    .background(.grayscaleWhite)
                    .tabItem {
                        Label("홈", image: "ic_home")
                    }
                    .environment(userInfoViewModel)
                
                TreeBranchView()
                    .tabItem {
                        Label("트리", image: "ic_tree")
                    }
                
                NotificationView()
                    .tabItem {
                        Label("알림", image: "ic_noti")
                    }
                    
                MyProfileView()
                    .background(.grayscaleWhite)
                    .tabItem {
                        Label("설정", image: "ic_setting")
                    }
                    .environment(userInfoViewModel)
            }
            .fontWithLineHeight(fontLevel: .caption2)
            .tint(.treeGreen)
            .environment(viewRouter)
            .environment(currentTreehouseInfoViewModel)
            .navigationDestination(for: ProfileRouter.self) { router in
                switch router {
                case .editProfileView:
                    viewRouter.buildScene(inputRouter: router, viewModel: userInfoViewModel)
                case .memberProfileView:
                    viewRouter.buildScene(inputRouter: router)
                }
            }
            .onAppear {
                if let currentTreehouseId = currentTreehouseInfoViewModel.currentTreehouseId {
                    viewRouter.selectedTreehouseId = currentTreehouseId
                    Task {
                        await currentTreehouseInfoViewModel.getReadTreehouseInfo(treehouseId: currentTreehouseId)
                    }
                } else {
                    if let userInfo = userInfoViewModel.userInfo, let treehouseId = userInfo.treehouses.first {
                        currentTreehouseInfoViewModel.currentTreehouseId = treehouseId
                        currentTreehouseInfoViewModel.userId = userInfo.findTreehouse(id: treehouseId)?.treehouseMemberId ?? 0
                        viewRouter.selectedTreehouseId = treehouseId
                        
                        Task {
                            await currentTreehouseInfoViewModel.getReadTreehouseInfo(treehouseId: treehouseId)
                        }
                    }
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
