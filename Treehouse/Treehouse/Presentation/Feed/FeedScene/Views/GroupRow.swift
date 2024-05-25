//
//  GroupRow.swift
//  Treehouse
//
//  Created by 티모시 킴 on 5/25/24.
//

import SwiftUI

struct GroupRow: View {
    
    // MARK: - Property
    
    var group: GroupStruct
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .stroke(group.currentTreeHouse ? .treeGreen : .gray3, lineWidth: 1)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(group.currentTreeHouse ? .treePale : .white)
                )
                .cornerRadius(12)
                .frame(width: SizeLiterals.Screen.screenWidth * 360 / 393, height: 73)
            
            HStack(spacing: 0) {
                group.groupImage
                    .resizable()
                    .frame(width: 36, height: 36)
                    .padding(.leading, 12)
                
                Text(group.groupName)
                    .font(.fontGuide(.heading4))
                    .foregroundColor(.grayscaleBlack)
                    .padding(.leading, 19)
                
                Spacer()
                
                Text("\(group.personnel)")
                    .font(.fontGuide(.body5))
                    .foregroundColor(group.currentTreeHouse ? .treeGreen : .gray5)
                    .padding(.trailing, 13)
                
                Button(action: {
                }) {
                    Image(group.currentTreeHouse ? .icNext : .icNextGray)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 12)
                }
            }
            .frame(width: SizeLiterals.Screen.screenWidth * 360 / 393, height: 73)
            .padding(.vertical, 3)
            
            Image(group.currentTreeHouse ? .icPerson : .icPersonGray)
                .frame(width: 18, height: 18)
                .offset(x: SizeLiterals.Screen.screenWidth * 100 / 393)
        }
    }
}

// MARK: - Preview

#Preview {
    let groups = GroupStruct.groupStructDummyData
    return Group {
        GroupRow(group: groups[0])
        GroupRow(group: groups[1])
    }
}
