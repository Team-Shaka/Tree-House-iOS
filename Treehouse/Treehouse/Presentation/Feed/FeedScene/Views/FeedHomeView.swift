//
//  FeedHomeView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 6/20/24.
//

import SwiftUI

struct FeedHomeView: View {
    
    // MARK: - State Property
    
    @Environment (ViewRouter.self) var viewRouter
    
    @State var isPresent = false
    @State private var groupName: String = "groupname"
    @State private var subject: String = "오늘 점심 뭐 먹지?"
    @State private var personnel: Int = 30
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(groupName: groupName, isPresent: $isPresent)
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .background(.grayscaleWhite)
            
            ScrollView(.vertical) {
                TreeHallView(groupName: groupName, subject: subject, personnel: personnel)
                
                FeedView()
                    .frame(width: SizeLiterals.Screen.screenWidth)
                    .environment(viewRouter)
            }
            .padding(.top, 10)
            .padding(.bottom, 16)
        }
        .navigationDestination(for: FeedRouter.self) { router in
            viewRouter.buildScene(inputRouter: router)
        }
        .navigationDestination(for: ProfileRouter.self) { router in
            viewRouter.buildScene(inputRouter: router)
        }
    }
}

// MARK: - Preview

#Preview {
    FeedHomeView()
        .environment(ViewRouter())
}
