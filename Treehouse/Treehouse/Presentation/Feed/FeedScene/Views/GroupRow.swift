//
//  GroupRow.swift
//  Treehouse
//
//  Created by 티모시 킴 on 5/25/24.
//

import SwiftUI

struct TreehouseInfoRow: View {
    
    // MARK: - Property
    
    var treehouseImageUrl: String
    var treehouseName: String
    var treehouseSize: Int
    var currentTreeHouse: Bool
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .stroke(currentTreeHouse ? .treeGreen : .gray3, lineWidth: 1)
                .fill(currentTreeHouse ? .treePale : .grayscaleWhite)
            
            HStack(spacing: 0) {
                CustomAsyncImage(url: treehouseImageUrl, type: .treehouseImage,
                                 width: 46,
                                 height: 46)
                //                    .frame(width: SizeLiterals.Screen.screenWidth * 46, height: SizeLiterals.Screen.screenHeight * 46)
//                .padding(.trailing, 12)
                
                Text(treehouseName)
                    .fontWithLineHeight(fontLevel: .heading4)
                    .foregroundColor(.grayscaleBlack)
                    .padding(.leading, 19)
                
                Spacer()
                
                Image(currentTreeHouse ? .icPerson : .icPersonGray)
                    .frame(width: 18, height: 18)
                
                Text("\(treehouseSize)")
                    .fontWithLineHeight(fontLevel: .body5)
                    .foregroundColor(currentTreeHouse ? .treeGreen : .gray5)
                    .padding(.trailing, 13)
                
                Image(currentTreeHouse ? .icNext : .icNextGray)
                    .frame(width: 24, height: 24)
//                    .padding(.trailing, 12)
            }
            .padding(12)
        }
        .frame(height: 70)
    }
}

// MARK: - Preview

//#Preview {
//    let groups = GroupStruct.groupStructDummyData
//    return Group {
//        GroupRow(group: groups[0])
//        GroupRow(group: groups[1])
//    }
//}
