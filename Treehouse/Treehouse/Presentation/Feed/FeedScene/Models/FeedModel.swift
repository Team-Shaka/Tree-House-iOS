//
//  FeedModel.swift
//  Treehouse
//
//  Created by 윤영서 on 4/26/24.
//

import Foundation
import SwiftUI

struct FeedModel: Identifiable, Hashable {
    let id = UUID()
    
    // group 관련
    let groupId: Int
    var groupName: String
    var voiceCount: Int
    
    // post 관련
    let postId: Int
    var userProfileImageURL: String
    var sentTime: Int
    var postContent: String
    var postImageURLs: [String]
    
    var userProfileImage: Image {
        Image(userProfileImageURL)
    }
    var postImages: [Image] { // 각 URL에 대해 Image 인스턴스를 생성하여 배열로 반환
        postImageURLs.map { Image($0) }
    }
}
