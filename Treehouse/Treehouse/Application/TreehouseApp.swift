//
//  TreehouseApp.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/7/24.
//

import SwiftUI
import SwiftData
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct TreehouseApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var viewRouter = ViewRouter()
    @AppStorage(Config.loginKey) private var isLogin = false
    
    init() {
        configureNavigationBar()
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
}
