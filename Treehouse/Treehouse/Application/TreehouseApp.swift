//
//  TreehouseApp.swift
//  Treehouse
//
//  Created by 티모시 킴 on 4/7/24.
//

import SwiftUI

@main
struct TreehouseApp: App {
    
    @State var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            switch viewRouter.currentView {
            case .userAuthentication:
                SetPhoneNumberView()
                    .environment(viewRouter)
            case .enterTreehouse:
                TreeTabView()
                    .environment(viewRouter)
            }
        }
    }
}
