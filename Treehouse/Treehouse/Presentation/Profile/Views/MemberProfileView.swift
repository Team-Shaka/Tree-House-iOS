//
//  MemberProfileView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 6/10/24.
//

import SwiftUI

struct MemberProfileView: View {
    
    // MARK: - State Property
    @Environment(ViewRouter.self) var viewRouter: ViewRouter
    @Environment (FeedViewModel.self) var feedViewModel
    
    @State var memberProfileViewModel: MemberProfileViewModel
    @State var emojiViewModel: EmojiViewModel = EmojiViewModel(createReactionToPostUseCase: CreateReactionToPostUseCase(repository: FeedRepositoryImpl()))
    @State var postViewModel = PostViewModel(readFeedPostUseCase: ReadFeedPostUseCase(repository: FeedRepositoryImpl()), createFeedPostsUseCase: CreateFeedPostsUseCase(repository: FeedRepositoryImpl()), readPageFeedPostUseCase: ReadPageFeedPostUseCase(repository: FeedRepositoryImpl()))
    
    @State var isPresent = false
    @State var isLoading = true
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    if let data = memberProfileViewModel.memberProfileData {
                        UserInfoView(infoType: .memberProfile,
                                     treememberName: data.memberName,
                                     userName: data.userName,
                                     profileImageUrl: data.profileImageUrl,
                                     bio: data.bio,
                                     branchCount: data.closestMemberCount,
                                     treeHouseCount: data.treehouseCount,
                                     root: "\(data.fromMe)",
                                     inviteAction: nil,
                                     branchAction: nil,
                                     profileAction: nil)
                        .padding(.top, 15)
                    }
                    
                    if let data = memberProfileViewModel.memberFeedData {
                        ForEach(data.postList) { feed in
                            VStack(spacing: 0) {
                                SinglePostView(postId: feed.postId,
                                               sentTime: feed.postedAt,
                                               postContent: feed.context,
                                               postImageURLs: feed.pictureUrlList,
                                               memberProfile: data.memberProfile,
                                               postType: .feedView)
                                
                                VStack(alignment: .leading, spacing: 0) {
                                    EmojiListView(emojiType: .feedView, postId: feed.postId, feedEmojiData: feed.reactionList)
                                        .environment(emojiViewModel)
                                        .environment(postViewModel)
                                        .padding(.top, 10)
                                        .onAppear {
                                            feedViewModel.currentPostId = feed.postId
                                        }
                                    
                                    CommentCountView(commentCount: feed.commentCount)
                                        .padding(.top, 10)
                                        .padding(.trailing, 16)
                                        .onTapGesture {
                                            feedViewModel.currentPostId = feed.postId
                                            viewRouter.push(FeedRouter.postDetailView)
                                        }
                                }
                                .padding(.leading, 62)
                                .padding(.bottom, 16)
                            }
                            .background(
                                Color.clear
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        feedViewModel.currentPostId = feed.postId
                                        viewRouter.push(FeedRouter.postDetailView)
                                    }
                            )
                        }
                    }
                }
            }
            .refreshable {
                await memberProfileViewModel.performAsyncTasks()
            }
            
            if memberProfileViewModel.isLoading == true {
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
        .navigationTitle(memberProfileViewModel.title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await memberProfileViewModel.performAsyncTasks()
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        MemberProfileView(
            memberProfileViewModel: MemberProfileViewModel(
                readMemberInfoUseCase: ReadMemberInfoUseCase(repository: MemberRepositoryImpl()),
                readMemberFeedUseCase: ReadMemberFeedUseCase(repository: MemberRepositoryImpl()),
                treehouseId: 0,
                memberId: 0
            )
        )
        .environment(ViewRouter())
    }
}

