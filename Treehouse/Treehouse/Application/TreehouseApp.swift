//
//  TreehouseApp.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/7/24.
//

import SwiftUI
import SwiftData
import Firebase
import FirebaseMessaging
import FirebaseAuth
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        // 파이어베이스 설정
        FirebaseApp.configure()
        Auth.auth().languageCode = "ko"
        
        UNUserNotificationCenter.current().delegate = self
        application.registerForRemoteNotifications()

        // Setting Up Cloud Messaging...
        // 메세징 델리겟
        Messaging.messaging().delegate = self
        
        return true
    }
    
    // APNS 토큰을 Firebase에 등록
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Firebase Messaging을 위한 설정
        Messaging.messaging().apnsToken = deviceToken
        
        // Firebase Auth를 위한 설정
        Auth.auth().setAPNSToken(deviceToken, type: AuthAPNSTokenType.sandbox)
    }

    // 원격 알림 처리
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // 다른 원격 알림 처리 로직
        let firebaseAuth = Auth.auth()
        if (firebaseAuth.canHandleNotification(userInfo)){
            print(userInfo)
            completionHandler(.noData)
            return
        }
        
        completionHandler(.newData)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // 앱이 종료될 때 캐시 제거
        URLCache.shared.removeAllCachedResponses()
        print("모든 캐시가 제거되었습니다.")
    }
}

@main
struct TreehouseApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var viewRouter = ViewRouter()
    @AppStorage(Config.loginKey) private var isLogin = false
    
    init() {
        configureNavigationBar()
        configureURLCache()
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isLogin {
                    TreeTabView()
                        .environment(viewRouter)
                } else {
                    SetPhoneNumberView()
                        .environment(viewRouter)
                }
            }
            .onAppear {
                print("\(URLCache.shared.memoryCapacity / 1024 / 1024) MB")
            }
        }
    }
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        
        // 배경색 및 title 색상 폰트 설정
        appearance.backgroundColor = UIColor.grayscaleWhite
        appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: +0, vertical: 0)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.treeBlack,
            .font: Font.uiFontGuide(.body2)
        ]
        
        let backButtonAppearance = UIBarButtonItemAppearance(style: .plain)
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear] // 뒤로가기 버튼의 텍스트 제거
        appearance.backButtonAppearance = backButtonAppearance
        appearance.shadowColor = .clear // 하단 선 제거
        
        // 뒤로가기 버튼 이미지 설정
        let backImage = UIImage.icBack.withTintColor(.treeBlack, renderingMode: .alwaysOriginal)
        appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private func configureURLCache() {
        
        let totalMemory = ProcessInfo.processInfo.physicalMemory
        let deviceAdjustedLimit = Int(Double(totalMemory) * 0.03)
        
        let memoryCapacity = 150 * 1024 * 1024 // 150 MB
        let diskCapacity = 100 * 1024 * 1024 // 100 MB
        
        let cacheLimit = min(memoryCapacity, deviceAdjustedLimit)
        
        let cache = URLCache(memoryCapacity: cacheLimit, diskCapacity: diskCapacity, diskPath: "myImages")
        URLCache.shared = cache
    }
}

// Cloud Messaging...
extension AppDelegate: MessagingDelegate{
    
    // fcm 등록 토큰을 받았을 때
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {

        print("토큰을 받았다")
        // Store this token to firebase and retrieve when to send message to someone...
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        
        // Store token in Firestore For Sending Notifications From Server in Future...
        
        print(dataDict)
     
    }
}

// User Notifications...[AKA InApp Notification...]

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 푸시 메세지가 앱이 켜져있을 때 나올떄
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo

        print(userInfo)
        
        completionHandler([[.banner, .badge, .sound]])
    }
    
    // 푸시메세지를 받았을 떄
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        print(userInfo)
        
        completionHandler()
    }
}
