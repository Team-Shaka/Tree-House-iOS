//
//  UserSettingViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/12/24.
//

import Observation

@Observable
final class UserSettingViewModel: BaseViewModel {
    
    var userId: String = ""
    var isPresentedView = false
    var isDuplicateID: Bool = false
    var isButtonEnabled: Bool = false
}

protocol BaseViewModel: AnyObject {}
