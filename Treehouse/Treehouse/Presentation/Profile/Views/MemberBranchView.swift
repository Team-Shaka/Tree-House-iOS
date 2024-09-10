//
//  MemberBranchView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 9/9/24.
//

import SwiftUI

struct MemberBranchView: View {
    
    // MARK: - State Property
    @Environment(ViewRouter.self) var viewRouter: ViewRouter
    @Environment(CurrentTreehouseInfoViewModel.self) var currentTreehouseInfoViewModel
    @State var treeBranchViewModel = TreeBranchViewModel(webViewType: .memberBranch)
    
    @AppStorage("treehouseId") private var selectedTreehouseId: Int = -1
    @State var isLoading = true
    
    let memberId: Int
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if treeBranchViewModel.webViewUrl.isEmpty {
                    VStack {
                        Spacer()
                        
                        LottieView(lottieFile: "treehouse_loading", speed: 1)
                            .frame(width: 100, height: 100)
                        
                        Spacer()
                    }
                } else {
                    WebView(url: $treeBranchViewModel.webViewUrl, isLoading: $isLoading)
                }
            }
        }
        .navigationTitle("브랜치 보기")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                await treeBranchViewModel.changetreeBranchUrl(treehouseId: selectedTreehouseId, myMemberId: currentTreehouseInfoViewModel.memberId, memberId: memberId)
            }
        }
    }
}

#Preview {
    MemberBranchView(memberId: 0)
}
