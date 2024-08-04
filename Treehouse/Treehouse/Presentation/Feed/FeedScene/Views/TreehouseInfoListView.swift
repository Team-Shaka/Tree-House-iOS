//
//  TreehouseInfoListView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/30/24.
//

import SwiftUI

struct TreehouseInfoListView: View {
    
    @Environment(ViewRouter.self) var viewRouter
    @Binding var treehouseInfoData: [ReadTreehouseInfoResponseEntity]?
    @Binding var isPresent: Bool
    
    var body: some View {
        LazyVStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 2.5)
                .frame(width: 50, height: 4)
                .foregroundStyle(.gray2)
                .padding(.top, 10)
                .padding(.bottom, 36)
            
            if let data = treehouseInfoData {
                ForEach(data) { data in
                    Button(action: {
//                        data.currentTreeHouse = true
                    }) {
                        TreehouseInfoRow(treehouseImageUrl: data.treehouseImageUrl ?? "",
                                         treehouseName: data.treehouseName,
                                         treehouseSize: data.treehouseSize,
                                         currentTreeHouse: data.currentTreeHouse
                        )
                    }
                }
            } else {
                // TODO: - 빈 화면 넣어야 합니다.
            }
            
            Button(action: {
                isPresent.toggle()
                
                if isPresent == false {
                    viewRouter.push(CreateTreehouseRouter.createTreehouseNameView)
                }
            }) {
                Text("+ 새로운 트리 만들기")
                    .fontWithLineHeight(fontLevel: .body2)
                    .foregroundStyle(.gray1)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(.treeBlack)
                    .cornerRadius(12)
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 34+29)
        .background(.grayscaleWhite)
        .selectCornerRadius(radius: 20, corners: [.topLeft, .topRight])
    }
}
