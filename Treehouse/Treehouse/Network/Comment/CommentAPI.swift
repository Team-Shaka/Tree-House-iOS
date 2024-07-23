//
//  CommentAPI.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/17/24.
//

import Foundation

enum CommentAPI {
    case getReadCommentsList(treehouseId: Int, postId: Int)
    case postCreateComment(treehouseId: Int, postId: Int, requestBody: PostCreateCommentRequestDTO)
    case postCreateReplyComment(treehouseId: Int, postId: Int, commentId: Int, requestBody: PostCreateCommentRequestDTO)
    case deleteComment(treehouseId: Int, postId: Int, commentId: Int)
    case postReactionComment(treehouseId: Int, postId: Int, commentId: Int, requestBody: PostReactionCommentRequestDTO)
    case postReportFeedComment(treehouseId: Int, postId: Int, commentId: Int, requestBody: PostReportFeedCommentRequestDTO)
}

extension CommentAPI: BaseRequest {
    var path: String {
        switch self {
        case .getReadCommentsList(treehouseId: let treehouseId, postId: let postId), .postCreateComment(treehouseId: let treehouseId, postId: let postId, _):
            return "treehouses/\(treehouseId)/feeds/posts/\(postId)/comments"
        case .postCreateReplyComment(treehouseId: let treehouseId, postId: let postId, let commentId, _),
                .deleteComment(treehouseId: let treehouseId, postId: let postId, commentId: let commentId):
            return "treehouses/\(treehouseId)/feeds/posts/\(postId)/comments\(commentId)"
        case .postReactionComment(treehouseId: let treehouseId, postId: let postId, commentId: let commentId, _):
            return "treehouses/\(treehouseId)/feeds/posts/\(postId)/comments/\(commentId)/reactions"
        case .postReportFeedComment(treehouseId: let treehouseId, postId: let postId, commentId: let commentId, _):
            return "treehouses/\(treehouseId)/feeds/posts/\(postId)/comments/\(commentId)/reports"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .getReadCommentsList:
            return .get
        case .postCreateComment, .postCreateReplyComment, .postReactionComment, .postReportFeedComment:
            return .post
        case .deleteComment:
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
        case .postCreateComment(_, _, requestBody: let requestBody):
            return requestBody
        case .postCreateReplyComment(_, _, _, requestBody: let requestBody):
            return requestBody
        case .postReactionComment(_, _, _, requestBody: let requestBody):
            return requestBody
        case .postReportFeedComment(_, _, _, requestBody: let requestBody):
            return requestBody
        default: return .none
        }
    }
}
