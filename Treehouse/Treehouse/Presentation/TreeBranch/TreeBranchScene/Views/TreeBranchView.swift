//
//  TreeBranchView.swift
//  Treehouse
//
//  Created by 윤영서 on 8/1/24.
//

import SwiftUI

struct TreeBranchView: View {
    @Environment(ViewRouter.self) var viewRouter: ViewRouter
        
    var body: some View {
        VStack {
            Spacer()
            
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
            }
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .foregroundStyle(.gray1)
            .background(.treeBlack)
            .cornerRadius(10)
            .padding(.horizontal, 16)
        }
        .padding(.bottom, 16)
        .navigationDestination(for: InvitationRouter.self) { router in
            viewRouter.buildScene(inputRouter: router)
        }
    }
}

#Preview {
    TreeBranchView()
        .environment(ViewRouter())
}
