//
//  TreehouseInfoListView.swift
//  Treehouse
//
//  Created by ParkJunHyuk on 7/30/24.
//

import SwiftUI

struct TreehouseInfoListView: View {
    
    @Environment(ViewRouter.self) var viewRouter
    @AppStorage("treehouseId") private var selectedTreehouseId: Int = -1
    @Binding var treehouseInfoData: [ReadTreehouseInfoResponseEntity]?
    @Binding var isPresent: Bool
    
    var body: some View {
        VStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 2.5)
                .frame(width: 50, height: 4)
                .foregroundStyle(.gray2)
                .padding(.top, 10)
                .padding(.bottom, 25)
            
            if let data = treehouseInfoData {
                List(data) { data in
                    Button(action: {
                        selectedTreehouseId = data.treehouseId
                        isPresent.toggle()
                    }) {
                        TreehouseInfoRow(treehouseImageUrl: data.treehouseImageUrl ?? "",
                                         treehouseName: data.treehouseName,
                                         treehouseSize: data.treehouseSize,
                                         currentTreeHouse: data.currentTreeHouse
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .listRowInsets(EdgeInsets(top: 7, leading: 16, bottom: 7, trailing: 16))
                    .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
                .frame(height: calculateHeight(for: data.count))
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
            .padding(.horizontal, 16)
        }
        .padding(.bottom, SizeLiterals.Screen.screenHeight * (34+29) / 852)
        .background(.grayscaleWhite)
        .selectCornerRadius(radius: 20, corners: [.topLeft, .topRight])
    }
    
    private func calculateHeight(for itemCount: Int) -> CGFloat {
        if itemCount == 1 {
            return 100
        } else {
            return 170
        }
    }
}
