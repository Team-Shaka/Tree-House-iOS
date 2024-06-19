//
//  MemberGroupRow.swift
//  Treehouse
//
//  Created by 티모시 킴 on 6/11/24.
//

import SwiftUI

struct MemberGroupRow: View {
    
    // MARK: - Property
    
    var group: MemberGroupStruct
    var isSelected: Bool
    var onTap: () -> Void
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? .treeGreen : .gray3, lineWidth: 1)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(isSelected ? .treePale : .grayscaleWhite)
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
                    .foregroundColor(isSelected ? .treeGreen : .gray5)
                    .padding(.trailing, 13)
                
                Button(action: {
                }) {
                    Image(isSelected ? .icNext : .icNextGray)
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 12)
                }
            }
            .frame(width: SizeLiterals.Screen.screenWidth * 360 / 393, height: 73)
            .padding(.vertical, 3)
            
            Image(isSelected ? .icPerson : .icPersonGray)
                .frame(width: 18, height: 18)
                .offset(x: SizeLiterals.Screen.screenWidth * 100 / 393)
        }
        .onTapGesture {
            onTap()
        }
    }
}

// MARK: - Preview

#Preview {
    let groups = MemberGroupStruct.memberGroupStructDummyData
    return Group {
        MemberGroupRow(group: groups[0], isSelected: false, onTap: {})
        MemberGroupRow(group: groups[1], isSelected: true, onTap: {})
    }
}
