//
//  CommentCountView.swift
//  Treehouse
//
//  Created by 윤영서 on 6/2/24.
//

import SwiftUI

struct CommentCountView: View {
    
    // MARK: - Property
    
    var commentCount: Int = 12
    
    // MARK: - View
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 315, height: 40)
                .foregroundColor(.gray1)
                .selectCornerRadius(radius: 10.0, corners: [.bottomLeft, .bottomRight, .topRight])
            
            HStack(spacing: 5) {
                Image(.icGreenReply)
                
                if commentCount < 10 {
                    Text("0\(commentCount) comments")
                        .font(.fontGuide(.body4))
                        .foregroundStyle(.gray7)
                } else {
                    Text("\(commentCount) comments")
                        .font(.fontGuide(.body4))
                        .foregroundStyle(.gray7)
                }
            }
            .padding(.trailing, 180)
        }
    }
}

#Preview {
    CommentCountView()
}
