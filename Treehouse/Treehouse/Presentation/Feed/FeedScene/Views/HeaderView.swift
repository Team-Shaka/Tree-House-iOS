//
//  HeaderView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 5/30/24.
//

import SwiftUI

struct HeaderView: View {
    
    // MARK: - State Property
    
    @Environment(ViewRouter.self) var viewRouter
    @Environment(CurrentTreehouseInfoViewModel.self) var currentTreehouseInfoViewModel
    @State var treehouseViewModel = TreehouseViewModel(readMyTreehouseInfoUseCase: ReadMyTreehouseInfoUseCase(repository: TreehouseRepositoryImpl()))
    
    // MARK: - Binding Property
    
    @State var isPresent: Bool = false
    
    // MARK: - View
    
    var body: some View {        
        HStack {
            CustomAsyncImage(url: currentTreehouseInfoViewModel.treehouseImageUrl,
                             type: .postMemberProfileImage,
                             width: 36,
                             height: 36)
                .clipShape(Circle())
                .padding(.leading, 16)
            
            Text(currentTreehouseInfoViewModel.treehouseName)
                .fontWithLineHeight(fontLevel: .heading4)
                .padding(.leading, 10)
            
            Spacer()
            
            Button(action: {
                isPresent.toggle()
                Task {
                    await treehouseViewModel.readMyTreehouseInfo(currentTreehouseId: currentTreehouseInfoViewModel.currentTreehouseId ?? 0)
                }
            }) {
                Image(.icChange)
                    .frame(width: 32, height: 32)
                    .padding(.trailing, 16)
            }
        }
        .redacted(reason: currentTreehouseInfoViewModel.isloading ? .placeholder : [])
        .popup(isPresented: $isPresent) {
            TreehouseInfoListView(treehouseInfoData: $treehouseViewModel.treehouseInfo,
                                  isPresent: $isPresent)
        } customize: {
            $0
                .type(.toast)
                .closeOnTapOutside(true)
                .dragToDismiss(true)
                .isOpaque(true)
                .backgroundColor(.treeBlack.opacity(0.5))
        }
    }
}
