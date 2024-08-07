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
}
