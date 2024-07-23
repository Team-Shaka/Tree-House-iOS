//
//  FeedAPI.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/22/24.
//

import Foundation

enum FeedAPI {
    case postCreateFeedPosts(treehouseId: Int, requestBody: PostCreateFeedPostsRequestDTO)
    case getReadFeedPostsList(treehouseId: Int)
    case getReadDetailFeedPosts(treehouseId: Int, postId: Int)
    case patchUpdateFeedPost(treehouseId: Int, postId: Int)
    case deleteFeedPost(treehouseId: Int, postId: Int)
    case postPresignedURL(treehouseId: Int, requestBody: PostPresignedURLRequestDTO)
    case postReportFeedPost(treehouseId: Int, postId: Int, requestBody: PostReportFeedPostRequestDTO)
    case postReactionFeedPost(treehouseId: Int, postId: Int, requestBody: PostReactionFeedPostRequestDTO)
}

extension FeedAPI: BaseRequest {
    var path: String {
        switch self {
        case .postCreateFeedPosts(let treehouseId, _):
            return "treehouses/\(treehouseId)/feeds/posts"
        case .getReadFeedPostsList(let treehouseId):
            return "treehouses/\(treehouseId)/feeds"
        case .getReadDetailFeedPosts(let treehouseId, let postId),
                .patchUpdateFeedPost(let treehouseId, let postId),
                .deleteFeedPost(let treehouseId, let postId):
            return "treehouses/\(treehouseId)/feeds/posts/\(postId)"
        case .postPresignedURL(let treehouseId, _):
            return "treehouses/\(treehouseId)/feeds/posts/images"
        case .postReportFeedPost(let treehouseId, let postId, _):
            return "treehouses/\(treehouseId)/feeds/posts/\(postId)/reports"
        case .postReactionFeedPost(let treehouseId, let postId, _):
            return "treehouses/\(treehouseId)/feeds/posts/\(postId)/reactions"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .postCreateFeedPosts, .postPresignedURL, .postReportFeedPost, .postReactionFeedPost:
            return .post
        case .getReadFeedPostsList, .getReadDetailFeedPosts:
            return .get
        case .patchUpdateFeedPost:
            return .patch
        case .deleteFeedPost:
            return .delete
        }
    }
    
    var headerType: HeaderType {
        return .accessTokenHeader
    }
    
    var body: Data? { return .none }

    var queryParameter: [String : Any]? { return .none }
    
    var requestBodyParameter: (any Codable)? {
        switch self {
        case .postCreateFeedPosts(_ , requestBody: let requestBody): return requestBody
        case .postPresignedURL(_, requestBody: let requestBody): return requestBody
        case .postReportFeedPost(_, _, requestBody: let requestBody): return requestBody
        case .postReactionFeedPost(_, _, requestBody: let requestBody): return requestBody
        default: return .none
        }
    }
}
