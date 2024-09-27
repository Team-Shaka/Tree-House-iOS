//
//  SettingView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 6/9/24.
//

import SwiftUI

enum SettingTitleState: String {
    case accountSetting = "계정 설정"
    case systemSetting = "시스템 설정"
    case aboutTreeHouse = "About Treehouse"
    case serviceSetting = "서비스 설정"
}

struct SettingView: View {
    
    @Environment(MyProfileViewModel.self) var myProfileViewModel
    @Environment(CurrentTreehouseInfoViewModel.self) var currentTreehouseInfoViewModel
    
    // MARK: - Property
    
    public var settingTitle: String
    public var settingList: [String]
    
    public init(state: SettingTitleState) {
        self.settingTitle = state.rawValue
        switch state {
        case .accountSetting:
            self.settingList = ["멤버 계정", "유저 계정"]
        case .systemSetting:
            self.settingList = ["알림"]
        case .aboutTreeHouse:
            self.settingList = ["고객센터", "운영정책", "개인정보정책", "앱스토어에 평가하기"]
        case .serviceSetting:
            self.settingList = ["로그아웃 하기", "회원탈퇴 하기"]
        }
    }
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Rectangle()
                .frame(height: 2)
                .foregroundColor(.gray2)
            
            Text(settingTitle)
                .fontWithLineHeight(fontLevel: .body4)
                .foregroundColor(.gray5)
                .padding(.top, 16)
                .padding(.leading, 16)
            
            ForEach(settingList, id: \.self) { settingOption in
                Button(action: {
                    myProfileViewModel.settingListButtonAction(titleName: settingOption)
                }) {
                    Text(settingOption)
                        .fontWithLineHeight(fontLevel: .body2)
                        .foregroundColor(.grayscaleBlack)
                        .padding(.top, 16)
                        .padding(.leading, 16)
                }
            }
        }
        .padding(.bottom, 17)
    }
}

// MARK: - Preview

#Preview {
    SettingView(state: .aboutTreeHouse)
}
