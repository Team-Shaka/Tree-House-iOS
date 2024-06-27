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
    let container = try! ModelContainer(for: UserInfoData.self)
    
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
        }.modelContainer(container)
    }
}
