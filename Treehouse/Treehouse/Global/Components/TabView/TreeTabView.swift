//
//  TreeTabView.swift
//  Treehouse
//
//  Created by 윤영서 on 4/26/24.
//

import SwiftUI

struct TreeTabView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView {
                HomeTab()
                    .tabItem {
                        Label("홈", image: "ic_home")
                    }
                
                TreeTab()
                    .tabItem {
                        Label("트리", image: "ic_tree")
                    }
                
                NotificationTab()
                    .tabItem {
                        Label("알림", image: "ic_noti")
                    }
                
                SettingsTab()
                    .tabItem {
                        Label("설정", image: "ic_setting")
                    }
            }
            .font(.fontGuide(.caption2))
            .tint(.treeGreen)
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .foregroundColor(.gray3)
                .padding(.bottom, 52)
        }
    }
}

#Preview {
    TreeTabView()
}
