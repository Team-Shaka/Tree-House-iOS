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
    
//    @State var isPresent = false
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .background(.grayscaleWhite)
                .environment(currentTreehouseInfoViewModel)
            
            ScrollView(.vertical) {
                FeedView()
                    .frame(width: SizeLiterals.Screen.screenWidth)
                    .environment(feedViewModel)
                    .environment(postViewModel)
                    .environment(emojiViewModel)
            }
            .padding(.bottom, 16)
            .refreshable {
                let _ = await postViewModel.readFeedPostsList(treehouseId: feedViewModel.currentTreehouseId ?? 0)
            }
        }
        .navigationDestination(for: FeedRouter.self) { router in
            viewRouter.buildScene(inputRouter: router, viewModel: feedViewModel)
        }
        .onAppear {
            feedViewModel.currentTreehouseId = currentTreehouseInfoViewModel.currentTreehouseId
            feedViewModel.userId = currentTreehouseInfoViewModel.userId
            feedViewModel.treehouseName = currentTreehouseInfoViewModel.treehouseName
        }
    }
}

// MARK: - Preview

#Preview {
    FeedHomeView()
        .environment(ViewRouter())
        .environment(UserInfoViewModel())
}
