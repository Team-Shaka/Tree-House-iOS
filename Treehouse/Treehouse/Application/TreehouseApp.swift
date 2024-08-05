//
//  TreehouseApp.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/7/24.
//

import SwiftUI
import SwiftData

@main
struct TreehouseApp: App {
    
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
