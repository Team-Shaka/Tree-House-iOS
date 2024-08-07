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
    @State private var notificationViewModel = NotificationViewModel(readNotificationUseCase: ReadNotificationUseCase(repository: NotificationsRepositoryImpl()), checkNotificationUseCase: CheckNotificationUseCase(repository: NotificationsRepositoryImpl()))
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
                .frame(maxWidth: .infinity)
                .background(.grayscaleWhite)
            
            ZStack {
                if notificationViewModel.notificationData.isEmpty == false {
                    List(notificationViewModel.notificationData.indices, id: \.self) { index in
                        let notification = notificationViewModel.notificationData[index]
                        NotificationRow(type: notification.type,
                                        subTitle: notification.body,
                                        profileImageUrl: notification.profileImageUrl ?? "",
                                        userName: notification.userName,
                                        receviedTime: notification.receivedTime,
                                        treehouseName: notification.treehouseName,
                                        isChecked: $notificationViewModel.notificationData[index].isChecked)
                        .redacted(reason: notificationViewModel.isLoading ? .placeholder : [])
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            Task {
                                await notificationViewModel.checkNotifications(notificationId: notification.notificationId)
                            }
                        }
                    }
                    .background(.grayscaleWhite)
                    .listStyle(PlainListStyle())
                    .refreshable {
                        await notificationViewModel.readNotifications()
                    }
                } else {
                    emptyNotificationView
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.grayscaleWhite)
                }
                
                if notificationViewModel.isLoading {
                    VStack {
                        Spacer()
                        
                        LottieView(lottieFile: "treehouse_loading", speed: 1)
                            .frame(width: 100, height: 100)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.grayscaleWhite)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await notificationViewModel.readNotifications()
        }
    }
}

// MARK: - ViewBuilder

extension NotificationView {
    @ViewBuilder
    var emptyNotificationView: some View {
        VStack(spacing: 12) {
            Image(.imgNotiempty)
                .background(.grayscaleWhite)
            
            Text(StringLiterals.Notification.notificationTitle1)
                .fontWithLineHeight(fontLevel: .heading4)
                .foregroundColor(.gray5)
        }
    }
    
    var headerView: some View {
        HStack {
            Text("알림")
                .fontWithLineHeight(fontLevel: .heading3)
                .foregroundStyle(.grayscaleBlack)
                .padding(.leading, 24)
                .padding(.vertical, 13)
            
            Spacer()
        }
    }
}

// MARK: - Preview

#Preview {
    NotificationView()
        .environment(ViewRouter())
}
