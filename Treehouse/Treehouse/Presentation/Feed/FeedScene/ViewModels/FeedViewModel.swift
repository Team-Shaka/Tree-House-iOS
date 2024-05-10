//
//  FeedViewModel.swift
//  Treehouse
//
//  Created by 윤영서 on 5/9/24.
//

import Observation

@Observable
final class FeedViewModel {
    var viewState : FeedViewStateType = .notEmpty
    var feedData: FeedModel? = nil
}
