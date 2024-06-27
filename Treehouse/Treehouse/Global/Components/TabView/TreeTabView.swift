//
//  TreeTabView.swift
//  Treehouse
//
//  Created by 윤영서 on 5/23/24.
//

import SwiftUI

struct TreeTabView: View {
    @Environment(ViewRouter.self) var viewRouter: ViewRouter
    
    var body: some View {
        @Bindable var viewRouter = viewRouter
        
        NavigationStack(path: $viewRouter.path) {
            TabView {
                FeedHomeView()
                    .tabItem {
                        Label("홈", image: "ic_home")
                    }
                
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
            }
            .font(.fontGuide(.caption2))
            .tint(.treeGreen)
            .environment(viewRouter)
        }
    }
}

#Preview {
    TreeTabView()
        .environment(ViewRouter())
}
