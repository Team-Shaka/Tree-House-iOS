//
//  NotificationRow.swift
//  Treehouse
//
//  Created by 윤영서 on 4/18/24.
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
    
    private var characterWidth: CGFloat {
        let font = Font.uiFontGuide(.body5) //UIFont.systemFont(ofSize: UIFont.systemFontSize)
        let textAttributes = [NSAttributedString.Key.font: font]
        let size = "\(userName + filteredSubTitle)".size(withAttributes: textAttributes)
        return size.width
    }
    
    private var characterWidthA: CGFloat {
        // 글자 스타일 정의
        let font = Font.fontGuide(.body5)
        let textAttributes = [NSAttributedString.Key.font: font]
        
        // 글자의 크기 계산
        let size = "A".size(withAttributes: textAttributes)
        return size.width
    }
    
    private var filteredSubTitle: String {
        // subTitle 문자열에서 userName 부분을 제거
        return subTitle.replacingOccurrences(of: userName, with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // MARK: - State Property
    
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
            let title = (userName+filteredSubTitle).replacingOccurrences(of: " ", with: "")
//            print("characterWidth:", characterWidth)
            print(title)
            print(subTitle)
            print(filteredSubTitle)
//            print("title 대략 길이:",(userName+filteredSubTitle).count * 9)
//            print("가능한 길이:",SizeLiterals.Screen.screenWidth-28-36-8)
            
            if Int((title).count * 9) <= Int(SizeLiterals.Screen.screenWidth-28-36-8) {
                tempStr = "\n"
            } else {
                tempStr = " "
            }
        }
    }
}

// MARK: - ViewBuilder

extension NotificationRow {
    @ViewBuilder
    var invitationImage: some View {
        if type == .invitation {
            Image(.icInvitation)
                .frame(width: 42, height: 42)
        }
    }
    
    @ViewBuilder
    var notificationText: some View {
        Text(userName.splitCharacter())
            .font(.fontGuide(.body4))
            .foregroundColor(.grayscaleBlack)
        
        + Text(filteredSubTitle.splitCharacter())
            .font(.fontGuide(.body5))
            .foregroundColor(.grayscaleBlack)
        
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

//#Preview {
//    NotificationRow(notification: NotificationModel.notificationDummyData[4])
//}
