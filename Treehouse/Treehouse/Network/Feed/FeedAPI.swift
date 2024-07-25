//
//  FeedAPI.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/22/24.
//

import Foundation

enum FeedAPI {
    case getReadFeedPostsList(treehouseId: Int)
    case postCreateFeedPosts(treehouseId: Int, requestBody: PostCreateFeedPostsRequestDTO)
    case getReadDetailFeedPosts(treehouseId: Int, postId: Int)
    case deleteFeedPost(treehouseId: Int, postId: Int)
    case patchUpdateFeedPost(treehouseId: Int, postId: Int)
    case postReactionFeedPost(treehouseId: Int, postId: Int, requestBody: PostReactionFeedPostRequestDTO)
    case postReportFeedPost(treehouseId: Int, postId: Int, requestBody: PostReportFeedPostRequestDTO)
    case postPresignedURL(treehouseId: Int, requestBody: PostPresignedURLRequestDTO)
}

extension FeedAPI: BaseRequest {
    var path: String {
        switch self {
        case .getReadFeedPostsList(treehouseId: let treehouseId):
            return "treehouses/\(treehouseId)/feeds"
        case .postCreateFeedPosts(treehouseId: let treehouseId, _):
            return "treehouses/\(treehouseId)/feeds/posts"
        case .getReadDetailFeedPosts(treehouseId: let treehouseId, postId: let postId),
                .deleteFeedPost(let treehouseId, let postId),
                .patchUpdateFeedPost(let treehouseId, let postId):
            return "treehouses/\(treehouseId)/feeds/posts/\(postId)"
        case .postReactionFeedPost(treehouseId: let treehouseId, postId: let postId, _):
            return "treehouses/\(treehouseId)/feeds/posts/\(postId)/reactions"
        case .postReportFeedPost(treehouseId: let treehouseId, postId: let postId, _):
            return "treehouses/\(treehouseId)/feeds/posts/\(postId)/reports"
        case .postPresignedURL(treehouseId: let treehouseId, _):
            return "treehouses/\(treehouseId)/feeds/posts/images"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .getReadFeedPostsList, .getReadDetailFeedPosts:
            return .get
        case .postCreateFeedPosts, .postReactionFeedPost, .postReportFeedPost, .postPresignedURL:
            return .post
        case .deleteFeedPost:
            return .delete
        case .patchUpdateFeedPost:
            return .patch
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
        case .postReactionFeedPost(_, _, requestBody: let requestBody): return requestBody
        case .postReportFeedPost(_, _, requestBody: let requestBody): return requestBody
        case .postPresignedURL(_, requestBody: let requestBody): return requestBody
        default: return .none
        }
    }
}
