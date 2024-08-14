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
    @State var postViewModel = PostViewModel(readFeedPostUseCase: ReadFeedPostUseCase(repository: FeedRepositoryImpl()), createFeedPostsUseCase: CreateFeedPostsUseCase(repository: FeedRepositoryImpl()), readPageFeedPostUseCase: ReadPageFeedPostUseCase(repository: FeedRepositoryImpl()))
    
    @State private var scrollViewProxy: ScrollViewProxy?
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .background(.grayscaleWhite)
                .environment(currentTreehouseInfoViewModel)
            
            ZStack {
                VStack {
                    ScrollViewReader { proxy in
                        ScrollView(.vertical) {
                            Color.clear.frame(height: 0)
                                .id("top")
                            
                            FeedView()
                                .frame(width: SizeLiterals.Screen.screenWidth)
                                .environment(feedViewModel)
                                .environment(postViewModel)
                                .environment(emojiViewModel)
                        }
                        .refreshable {
                            URLCache.shared.removeAllCachedResponses()
                            postViewModel.feedPageNum = 0
                            let _ = await postViewModel.readFeedPostsList(treehouseId: feedViewModel.currentTreehouseId ?? 0)
                        }
                        .onChange(of: viewRouter.isSameTap) { _ , newValue in
                            if newValue && viewRouter.selectedTab == .home {
                                withAnimation {
                                    proxy.scrollTo("top", anchor: .top)
                                }
                                
                                viewRouter.isSameTap.toggle()
                            }
                        }
                    }
                }
                
                if postViewModel.isLoading == false {
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
            feedViewModel.userId = currentTreehouseInfoViewModel.userId
            feedViewModel.treehouseName = currentTreehouseInfoViewModel.treehouseName
            
            Task {
                if feedViewModel.dataLoaded == false {
                    feedViewModel.dataLoaded = await postViewModel.readFeedPostsList(treehouseId: feedViewModel.currentTreehouseId ?? 0)
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
