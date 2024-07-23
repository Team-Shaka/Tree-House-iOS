//
//  FeedViewModel.swift
//  Treehouse
//
//  Created by 윤영서 on 5/9/24.
//

import Foundation
import Observation

@Observable
final class FeedViewModel: BaseViewModel {
    var viewState : FeedViewStateType = .notEmpty
    var feedData: FeedModel? = nil
    var groupName: String = "정보없음"
    
    @ObservationIgnored
    var currentTreehouseId: Int?
    
    @ObservationIgnored
    var currentPostId: Int?
    
    @ObservationIgnored
    var currentCommentId: Int?
}
