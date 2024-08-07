//
//  NotificationView.swift
//  Treehouse
//
//  Created by 윤영서 on 4/19/24.
//

import SwiftUI

struct NotificationView: View {
    
    // MARK: - Property
    @Environment(ViewRouter.self) var viewRouter: ViewRouter
    let notifications = NotificationModel.notificationDummyData
    
    // MARK: - View
    
    var body: some View {
        Group {
            if !notifications.isEmpty {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(notifications) { notification in
//                            NotificationRow(notification: notification)
                        }
                    }
                }
                
            } else {
                emptyNotificationView
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - ViewBuilder

extension NotificationView {
    @ViewBuilder
    var emptyNotificationView: some View {
        VStack(spacing: 12) {
            Image(.imgNotiempty)
            
            Text(StringLiterals.Notification.notificationTitle1)
                .font(.fontGuide(.heading4))
                .foregroundColor(.gray5)
        }
    }
}

// MARK: - Preview

#Preview {
    NotificationView()
        .environment(ViewRouter())
}
