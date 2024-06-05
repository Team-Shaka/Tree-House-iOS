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
            SetPhoneNumberView()
                .environment(viewRouter)
        }
    }
}
