//
//  TreeHallView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 5/16/24.
//

import SwiftUI

struct TreeHallView: View {
    
    // MARK: - Property
    
    var groupName: String = "groupname"
    var subject: String = "오늘 점심 뭐 먹지?"
    var personnel: Int = 30
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                Image(.icVoice)
                    .padding(.leading, 8)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(groupName)의 트리홀")
                        .fontWithLineHeight(fontLevel: .caption1)
                        .foregroundColor(.treeLightgreen)
                    
                    Text(subject)
                        .fontWithLineHeight(fontLevel: .heading4)
                        .foregroundColor(.treePale)
                }
                .padding(.leading, 12)
                
                Spacer()
                
                Image(.icVoicePerson)
                    .padding(.trailing, 5)
                
                Text("\(personnel)명 참여중")
                    .fontWithLineHeight(fontLevel: .body5)
                    .foregroundColor(.treeLightgreen)
                    .padding(.trailing, 7)
                
                Image(.icVoice)
                    .padding(.trailing, 8)
            }
            
            if personnel != 0 {
                Circle()
                    .frame(width: 5, height: 5)
                    .foregroundColor(.error)
                    .offset(x: SizeLiterals.Screen.screenWidth * 166/393, y: -31)
            }
        }
        .frame(width: SizeLiterals.Screen.screenWidth * 361/393, height: 92)
        .background(.treeBlack)
        .cornerRadius(8)
    }
}

// MARK: - Preview

#Preview {
    TreeHallView()
}
