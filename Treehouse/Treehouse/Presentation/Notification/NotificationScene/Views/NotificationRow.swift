////
////  NotificationRow.swift
////  Treehouse
////
////  Created by 윤영서 on 4/18/24.
////
//

import SwiftUI

struct NotificationRow: View {
    
    // MARK: - Property
    
    var type: NotificationTypeEnum
    var subTitle: String
    var profileImageUrl: String
    var userName: String
    var receviedTime: String
    var treehouseName: String
    
    /// UserName 과 usbTitle 을 더한 글자 width
    private var characterWidth: Int {
        let font = Font.uiFontGuide(.body5)
        let textAttributes = [NSAttributedString.Key.font: font]
        let size = "\(userName + subTitle)".size(withAttributes: textAttributes)
        return Int(size.width)
    }
    
    // MARK: - State Property
    
    @Binding var isChecked: Bool
    @State var tempStr = " "
    
    // MARK: - View
    
    var body: some View {
        HStack(spacing: 0) {
            CustomAsyncImage(url: profileImageUrl,
                             type: .notiProfileImage,
                             width: 36,
                             height: 36)
            .clipShape(Circle())
            .padding(.vertical, 3)
            .padding(.trailing, 8)
            
            notificationText
                .frame(maxWidth: .infinity, alignment: .leading)
            
            invitationImage
        }
        .padding(EdgeInsets(top: 14, leading: 16, bottom: 16, trailing: 14))
        .background(.grayscaleWhite)
        .onAppear {
            /// 한줄에 얼만큼 표기를 할 것인지 시간과 treehouseName 의 위치를 설정하는 switch
            switch type {
            case .invitation:
                if characterWidth <= Int(SizeLiterals.Screen.screenWidth-28-36-8-42) {
                    tempStr = "\n"
                } else {
                    tempStr = " "
                }
            default:
                if characterWidth <= Int(SizeLiterals.Screen.screenWidth-28-36-8) {
                    tempStr = "\n"
                } else {
                    tempStr = " "
                }
            }
        }
    }
}

// MARK: - ViewBuilder

extension NotificationRow {
    @ViewBuilder
    var invitationImage: some View {
        if type == .invitation {
            Image(isChecked ? .icInvitationGray : .icInvitation)
                .frame(width: 42, height: 42)
        }
    }
    
    @ViewBuilder
    var notificationText: some View {
        Text(userName.splitCharacter())
            .font(.fontGuide(.body4))
            .foregroundColor(isChecked ? .gray6 : .grayscaleBlack)
        
        + Text(subTitle.splitCharacter())
            .font(.fontGuide(.body5))
            .foregroundColor(isChecked ? .gray6 : .grayscaleBlack)
        
        + Text(tempStr + "\(receviedTime.splitCharacter())ㆍ")
            .font(.fontGuide(.body5))
            .foregroundColor(.gray6)
        
        + Text(treehouseName.splitCharacter())
            .font(.fontGuide(.body5))
            .foregroundColor(.gray6)
    }
}

struct ViewWidthKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - Preview

#Preview {
    NotificationRow(type: .comment,
                    subTitle: "님이 게시글에 😀을(를) 눌렀습니다.",
                    profileImageUrl: "",
                    userName: "테스트 중",
                    receviedTime: "1분 전",
                    treehouseName: "atree",
                    isChecked: .constant(false),
                    tempStr: " ")
}
