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
    case postCreateComment(treehouseId: Int, postId: Int, requestBody: PostCreateCommentRequestDTO)
    case getReadComment(treehouseId: Int, postId: Int)
    case deleteComment(treehouseId: Int, postId: Int, commentId: Int)
    case postPresignedURL(treehouseId: Int, requestBody: PostPresignedURLRequestDTO)
    case postReportFeedPost(treehouseId: Int, postId: Int, requestBody: PostReportFeedPostRequestDTO)
    case postReportFeedComment(treehouseId: Int, postId: Int, commentId: Int, requestBody: PostReportFeedCommentRequestDTO)
    case postReactionFeedPost(treehouseId: Int, postId: Int, requestBody: PostReactionFeedPostRequestDTO)
    case postReactionComment(treehouseId: Int, postId: Int, commentId: Int, requestBody: PostReactionCommentRequestDTO)
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
        case .postCreateComment(let treehouseId, let postId, _),
                .getReadComment(let treehouseId, let postId):
            return "treehouses/\(treehouseId)/feeds/posts/\(postId)/comments"
        case .deleteComment(let treehouseId, let postId, let commentId):
            return "treehouses/\(treehouseId)/feeds/posts/\(postId)/comments/\(commentId)"
        case .postPresignedURL(let treehouseId, _):
            return "treehouses/\(treehouseId)/feeds/posts/images"
        case .postReportFeedPost(let treehouseId, let postId, _):
            return "treehouses/\(treehouseId)/feeds/posts/\(postId)/reports"
        case .postReportFeedComment(let treehouseId, let postId, let commentId, _):
            return "treehouses/\(treehouseId)/feeds/posts/\(postId)/comments/\(commentId)/reports"
        case .postReactionFeedPost(let treehouseId, let postId, _):
            return "treehouses/\(treehouseId)/feeds/posts/\(postId)/reactions"
        case .postReactionComment(let treehouseId, let postId, let commentId, _):
            return "treehouses/\(treehouseId)/feeds/posts/\(postId)/comments/\(commentId)/reactions"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .postCreateFeedPosts,.postCreateComment, .postPresignedURL, .postReportFeedPost,
                .postReportFeedComment, .postReactionFeedPost, .postReactionComment:
            return .post
        case .getReadFeedPostsList, .getReadDetailFeedPosts, .getReadComment:
            return .get
        case .patchUpdateFeedPost:
            return .patch
        case .deleteFeedPost, .deleteComment:
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
        case .postCreateComment(_, _, requestBody: let requestBody): return requestBody
        case .postPresignedURL(_, requestBody: let requestBody): return requestBody
        case .postReportFeedPost(_, _, requestBody: let requestBody): return requestBody
        case .postReportFeedComment(_, _, _, requestBody: let requestBody): return requestBody
        case .postReactionFeedPost(_, _, requestBody: let requestBody): return requestBody
        case .postReactionComment(_, _, _, requestBody: let requestBody): return requestBody
        default: return .none
        }
    }
}
