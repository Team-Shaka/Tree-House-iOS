//
//  TreeBranchViewModel.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 9/9/24.
//

import Foundation
import Observation

enum WebViewType {
    case treeBranch
    case memberBranch
}

@Observable
final class TreeBranchViewModel: BaseViewModel {
    
    var webViewType: WebViewType
    var webViewUrl = ""
    
    init(webViewType: WebViewType) {
        self.webViewType = webViewType
    }
    
    func changetreeBranchUrl(treehouseId: Int?, myMemberId: Int? = nil, memberId: Int?) async {
        if let token = KeychainHelper.shared.load(for: Config.accessTokenKey) {
            guard let treeId = treehouseId else { return }
            
            switch webViewType {
            case .treeBranch:
                webViewUrl = Config.webFrontURL + "tree/\(treeId)?token=\(token)"
                print("주소:", webViewUrl)
            case .memberBranch:
                guard let memberId = memberId else { return }
                guard let myMemberId = myMemberId else { return }
                
                webViewUrl = Config.webFrontURL + "member/\(treeId)?&sourceMemberId=\(myMemberId)&targetMemberId=\(memberId)&token=\(token)"
                print("주소:", webViewUrl)
            }
        }
    }
}
