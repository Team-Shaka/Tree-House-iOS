//
//  TreehouseCreatingSuccessView.swift
//  Treehouse
//
//  Created by 윤영서 on 6/21/24.
//

import SwiftUI

struct TreehouseCreatingSuccessView: View {

    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            noAcceptationView
        }
    }
}

private extension TreehouseCreatingSuccessView {
    
    // MARK: - ViewBuilder
    
    @ViewBuilder
    var noAcceptationView: some View {
        VStack(alignment: .center,spacing: 24) {
            Spacer()
            
            Image(.imgFeedempty)
            
            Text(StringLiterals.CreateTreehouse.createTreehouseTitle1)
                .fontWithLineHeight(fontLevel: .body3)
                .foregroundStyle(.gray5)
                .multilineTextAlignment(.center)
            
            Spacer()
            
            ZStack {
                RoundedRectangle(cornerRadius: 10.0)
                    .foregroundStyle(.treePale)
                    .frame(width: 351, height: 70)
                
                Text(StringLiterals.CreateTreehouse.createTreehouseTitle2)
                    .fontWithLineHeight(fontLevel: .body3)
                    .foregroundStyle(.treeGreen)
            }
            .padding(.bottom, 20)
        }
    }
}

// MARK: - Preview

#Preview {
    TreehouseCreatingSuccessView()
}
