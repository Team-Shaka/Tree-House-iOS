//
//  FeedRepositoryProtocol.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/13/24.
//

import Foundation

protocol FeedRepositoryProtocol {
    func postPresignedURL(treehouseId: Int, fileName: String, fileSize: Int) async -> Result<PresignedURLResponseEntity,NetworkError>
    func getReadPost(treehouseId: Int) async -> Result<[GetReadFeedPostListResponseEntity], NetworkError>
    func getPageReadFeedPost(treehouseId: Int, page: Int) async -> Result<[GetReadFeedPostListResponseEntity], NetworkError>
    func postCreateFeedPosts(treehouseId: Int, requestBody: PostCreateFeedPostsRequestDTO) async -> Result<CreateFeedPostsResponseResponseEntity, NetworkError>
    func patchUpdateFeedPost(treehouseId: Int, postId: Int, context: String) async -> Result<UpdateFeedPostResponseEntity, NetworkError>
    func getReadDetailPost(treehouseId: Int, postId: Int) async -> Result<GetReadDetailFeedPostResponseEntity, NetworkError>
    func postCreateReactionToPost(treehouseId: Int, postId: Int, requestDTO: PostReactionFeedPostRequestDTO) async -> Result<String, NetworkError>
}
