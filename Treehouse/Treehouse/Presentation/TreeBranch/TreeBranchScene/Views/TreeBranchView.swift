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
        if let treehouseId = viewRouter.selectedTreehouseId {
//            WebView(path: "branchView/tree/\(treehouseId)")
//                .edgesIgnoringSafeArea(.all)
            Text("WebView")
        } else {
            Text("트리하우스 ID를 선택해주세요.")
        }
    }
}

#Preview {
    TreeBranchView()
        .environment(ViewRouter())
}
