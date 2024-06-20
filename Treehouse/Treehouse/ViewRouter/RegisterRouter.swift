//
//  RegisterRouter.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 5/15/24.
//

import SwiftUI
import Observation

enum RegisterRouter: Router {
    typealias ContentView = AnyView
    
    case setPhoneNumberView
    case verificationView
    case unableRegisterView
    case loginView
    case setUserIdView
    case showUserProfileView
    case receivedFirstInvitationView
    case setMemberProfileNameView
    case setMemberProfileImageView
    case setMemberBioView
    case showMemberProfileView
    
    func buildView(_ viewModel: BaseViewModel?) -> ContentView {
        if let viewModel = viewModel as? UserSettingViewModel {
            switch self {
            case .setPhoneNumberView:
                return AnyView(SetPhoneNumberView()
                    .environment(viewModel))
            case .verificationView:
                return AnyView(VerificationView()
                    .environment(viewModel))
            case .unableRegisterView:
                return AnyView(UnableRegisterView()
                    .environment(viewModel))
            case .loginView:
                return AnyView(LoginView()
                    .environment(viewModel))
            case .setUserIdView:
                return AnyView(SetUserIdView()
                    .environment(viewModel))
            case .showUserProfileView:
                return AnyView(ShowUserProfileView()
                    .environment(viewModel))
            case .receivedFirstInvitationView:
                return AnyView(ReceivedFirstInvitaionView()
                    .environment(viewModel))
            case .setMemberProfileNameView:
                return AnyView(SetMemberProfileNameView()
                    .environment(viewModel))
            case .setMemberProfileImageView:
                return AnyView(SetMemberProfileImage()
                    .environment(viewModel))
            case .setMemberBioView:
                return AnyView(SetMemberBioView()
                    .environment(viewModel))
            case .showMemberProfileView:
                return AnyView(ShowMemberProfileView()
                    .environment(viewModel))
            }
        } else {
            return AnyView(EmptyView())
        }
    }
}
