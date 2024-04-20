//
//  NotificationRow.swift
//  Treehouse
//
//  Created by 윤영서 on 4/18/24.
//

import SwiftUI

struct NotificationRow: View {
    
    // MARK: - Property
    
    var notification: NotificationStruct
    var textColor: Color {
        notification.isChecked ? .gray6 : .treeBlack
    }
    
    // MARK: - View
    
    var body: some View {
        HStack(alignment: .center) {
            notification.profileImage
                .resizable()
                .scaledToFill()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
                .padding(.top, 3)
                .padding(.trailing, 8)
            
            Text(notification.userName)
                .font(.fontGuide(.body4))
                .foregroundColor(textColor)
            
            + Text(notification.type.notificationContent)
                .font(.fontGuide(.body3))
                .foregroundColor(textColor)
            
            + Text(" \(notification.time)ㆍ")
                .font(.fontGuide(.body3))
                .foregroundColor(.gray6)
            
            + Text(notification.tree)
                .font(.fontGuide(.body3))
                .foregroundColor(.gray6)
            
            if notification.type == .inviteToTree {
                notification.isChecked ? Image(.icInvitationGray) : Image(.icInvitation)
            }
        }
        .padding(EdgeInsets(top: 14, leading: 16, bottom: 16, trailing: 14))
    }
}

// MARK: - Preview

#Preview {
    NotificationRow(notification: NotificationStruct.notificationDummyData[4])
}
