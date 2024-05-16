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
    
    func buildView(_ viewModel: BaseViewModel?) -> AnyView {
        if let viewModel = viewModel as? UserSettingViewModel {
            switch self {
            case .setPhoneNumberView:
                return AnyView(SetPhoneNumberView())
            case .verificationView:
                return AnyView(VerificationView())
            case .unableRegisterView:
                return AnyView(UnableRegisterView())
            case .loginView:
                return AnyView(LoginView())
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
            }
        } else {
            return AnyView(EmptyView())
        }
    }
}
