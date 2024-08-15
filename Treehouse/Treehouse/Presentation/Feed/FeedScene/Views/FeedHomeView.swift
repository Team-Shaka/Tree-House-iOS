//
//  FeedHomeView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/20/24.
//

import SwiftUI

struct FeedHomeView: View {
    
    // MARK: - State Property
    
    @Environment(ViewRouter.self) var viewRouter
    @Environment(UserInfoViewModel.self) var userInfoViewModel: UserInfoViewModel
    @Environment(CurrentTreehouseInfoViewModel.self) var currentTreehouseInfoViewModel
    
    @State var feedViewModel: FeedViewModel = FeedViewModel(getReadTreehouseInfoUseCase: ReadTreehouseInfoUseCase(repository: TreehouseRepositoryImpl()))
    @State var emojiViewModel: EmojiViewModel = EmojiViewModel(createReactionToPostUseCase: CreateReactionToPostUseCase(repository: FeedRepositoryImpl()))
    @State var postViewModel = PostViewModel(readFeedPostUseCase: ReadFeedPostUseCase(repository: FeedRepositoryImpl()), createFeedPostsUseCase: CreateFeedPostsUseCase(repository: FeedRepositoryImpl()))
    @AppStorage("treehouseId") private var selectedTreehouseId: Int = -1
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .background(.grayscaleWhite)
                .environment(currentTreehouseInfoViewModel)
            
            ZStack {
                if currentTreehouseInfoViewModel.treehouseSize >= 2 {
                    VStack {
                        ScrollView(.vertical) {
                            FeedView()
                                .frame(width: SizeLiterals.Screen.screenWidth)
                                .environment(feedViewModel)
                                .environment(postViewModel)
                                .environment(emojiViewModel)
                        }
                        .refreshable {
                            let _ = await postViewModel.readFeedPostsList(treehouseId: feedViewModel.currentTreehouseId ?? 0)
                        }
                    }
                } else {
                    TreehouseCreatingSuccessView()
                }
                
                if postViewModel.isLoading {
                    VStack {
                        Spacer()
                        
                        LottieView(lottieFile: "treehouse_loading", speed: 1)
                            .frame(width: 100, height: 100)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.grayscaleWhite)
                }
            }
        }
        .navigationBarHidden(true)
        .navigationDestination(for: FeedRouter.self) { router in
            viewRouter.buildScene(inputRouter: router, viewModel: feedViewModel)
        }
        .navigationDestination(for: ProfileRouter.self) { router in
            switch router {
            case .editProfileView:
                viewRouter.buildScene(inputRouter: router, viewModel: userInfoViewModel)
            case .memberProfileView:
                viewRouter.buildScene(inputRouter: router, viewModel: feedViewModel)
            }
        }
        .onAppear {
            feedViewModel.currentTreehouseId = currentTreehouseInfoViewModel.currentTreehouseId
            feedViewModel.userId = userInfoViewModel.userInfo?.findTreehouse(id: currentTreehouseInfoViewModel.currentTreehouseId ?? 0)?.treehouseMemberId ?? 0
            feedViewModel.treehouseName = currentTreehouseInfoViewModel.treehouseName
            
            Task {
                if feedViewModel.dataLoaded == false {
                    feedViewModel.dataLoaded = await postViewModel.readFeedPostsList(treehouseId: feedViewModel.currentTreehouseId ?? 0)
                }
            }
        }
        .onChange(of: viewRouter.selectedTreehouseId) { _, newValue in
            postViewModel.isLoading = true
            feedViewModel.currentTreehouseId = currentTreehouseInfoViewModel.currentTreehouseId
            Task {
                feedViewModel.dataLoaded = await postViewModel.readFeedPostsList(treehouseId: feedViewModel.currentTreehouseId ?? 0)
                await MainActor.run {
                    self.postViewModel.isLoading = true
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    FeedHomeView()
        .environment(ViewRouter())
        .environment(UserInfoViewModel())
}
