//
//  FeedHomeView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/20/24.
//

import SwiftUI

struct FeedHomeView: View {
    
    // MARK: - State Property
    
    @Environment (ViewRouter.self) var viewRouter
    @Environment(UserInfoViewModel.self) var userInfoViewModel: UserInfoViewModel
    @State var feedViewModel: FeedViewModel = FeedViewModel()
    
    @State var isPresent = false
    @State private var subject: String = "오늘 점심 뭐 먹지?"
    @State private var personnel: Int = 30
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(groupName: feedViewModel.groupName, isPresent: $isPresent)
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .background(.grayscaleWhite)
            
            ScrollView(.vertical) {
                TreeHallView(groupName: feedViewModel.groupName, subject: subject, personnel: personnel)
                    .padding(.top, 10)
                
                FeedView()
                    .frame(width: SizeLiterals.Screen.screenWidth)
            }
            .padding(.bottom, 16)
        }
        .navigationDestination(for: FeedRouter.self) { router in
            viewRouter.buildScene(inputRouter: router, viewModel: feedViewModel)
        }
        .onAppear {
            if feedViewModel.currentTreehouseId == nil {
                if let treehouseData = userInfoViewModel.safeUserInfo.treehouseId.first {
                    feedViewModel.currentTreehouseId = treehouseData.treehouseId
                    feedViewModel.groupName = treehouseData.treehouseName
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    FeedHomeView()
        .environment(ViewRouter())
}
