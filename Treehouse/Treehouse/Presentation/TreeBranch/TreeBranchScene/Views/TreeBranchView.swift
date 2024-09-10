//
//  TreeBranchView.swift
//  Treehouse
//
//  Created by 윤영서 on 8/1/24.
//

import SwiftUI

struct TreeBranchView: View {
    
    // MARK: - State Property
    @Environment(ViewRouter.self) var viewRouter: ViewRouter
    @Environment(CurrentTreehouseInfoViewModel.self) var currentTreehouseInfoViewModel
    @State var treeBranchViewModel = TreeBranchViewModel(webViewType: .treeBranch)
    
    @AppStorage("treehouseId") private var selectedTreehouseId: Int = -1
    @State var isLoading = true
    @State var url = ""
    
    // MARK: - View
        
    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .background(.grayscaleWhite)
                .environment(currentTreehouseInfoViewModel)
            
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
            
            Button(action: {
                viewRouter.push(InvitationRouter.inviteBranchView)
            }) {
                HStack(spacing: 0) {
                    Image(.icInvitation)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 4)
                    
                    Text("초대장 확인하기")
                        .fontWithLineHeight(fontLevel: .body4)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .foregroundStyle(.gray1)
                .background(.treeBlack)
                .cornerRadius(10)
            }
            .padding(.horizontal, 16)
        }
        .padding(.bottom, 16)
        .navigationDestination(for: InvitationRouter.self) { router in
            viewRouter.buildScene(inputRouter: router)
        }
        .onAppear {
            Task {
                await treeBranchViewModel.changetreeBranchUrl(treehouseId: selectedTreehouseId, memberId: nil)
            }
        }
        .onChange(of: selectedTreehouseId) {  _, newValue in
            Task {
                await treeBranchViewModel.changetreeBranchUrl(treehouseId: selectedTreehouseId, memberId: nil)
            }
        }
    }
}

#Preview {
    TreeBranchView()
        .environment(ViewRouter())
}
