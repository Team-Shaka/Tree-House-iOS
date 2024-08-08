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
    @AppStorage("treehouseId") private var selectedTreehouseId: Int = -1
    
    // MARK: - View
    
    var body: some View {
        @Bindable var viewRouter = viewRouter
        
        NavigationStack(path: $viewRouter.path) {
            TabView {
                FeedHomeView()
                    .background(.grayscaleWhite)
                    .tabItem {
                        Label("홈", image: "ic_home")
                            .fontWithLineHeight(fontLevel: .caption2)
                    }
                    .environment(userInfoViewModel)
                
                TreeTab()
                    .tabItem {
                        Label("트리", image: "ic_tree")
                            .fontWithLineHeight(fontLevel: .caption2)
                    }
                
                NotificationView()
                    .tabItem {
                        Label("알림", image: "ic_noti")
                            .fontWithLineHeight(fontLevel: .caption2)
                    }
                
                MyProfileView()
                    .background(.grayscaleWhite)
                    .tabItem {
                        Label("설정", image: "ic_setting")
                            .fontWithLineHeight(fontLevel: .caption2)
                    }
                    .environment(userInfoViewModel)
            }
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
            .navigationDestination(for: CreateTreehouseRouter.self) { router in
                viewRouter.buildScene(inputRouter: router)
            }
            .onAppear {
                if selectedTreehouseId != -1 {
                    currentTreehouseInfoViewModel.currentTreehouseId = selectedTreehouseId
                }
                
                if let currentTreehouseId = currentTreehouseInfoViewModel.currentTreehouseId {
                    Task {
                        await currentTreehouseInfoViewModel.getReadTreehouseInfo(treehouseId: currentTreehouseId)
                    }
                } else {
                    if let userInfo = userInfoViewModel.userInfo, let treehouseId = userInfo.treehouses.first {
                        currentTreehouseInfoViewModel.currentTreehouseId = treehouseId
                        currentTreehouseInfoViewModel.userId = userInfo.findTreehouse(id: treehouseId)?.treehouseMemberId ?? 0
                        
                        selectedTreehouseId = treehouseId
                        
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
            .onChange(of: selectedTreehouseId) { _, newValue in
                print("변경전: ", currentTreehouseInfoViewModel.currentTreehouseId)
                currentTreehouseInfoViewModel.currentTreehouseId = newValue
                print("변경됨: ", currentTreehouseInfoViewModel.currentTreehouseId)
            }
        }
    }
}

// MARK: - Preview

#Preview {
    TreeTabView()
        .environment(ViewRouter())
}
