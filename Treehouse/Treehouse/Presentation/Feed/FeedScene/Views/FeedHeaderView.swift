//
//  FeedHeaderView.swift
//  Treehouse
//
//  Created by 티모시 킴 on 5/23/24.
//

import SwiftUI

struct FeedHeaderView: View {
    
    @State private var groupName: String = "groupname"
    @State private var subject: String = "오늘 점심 뭐 먹지?"
    @State private var personnel: Int = 30
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(groupName: groupName)
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .background(Color.white)
            
            ScrollView {
                VStack {
                    TreeHallView(groupName: groupName, subject: subject, personnel: personnel)
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 16)
        }
    }
    
}

struct HeaderView: View {
    var groupName: String
    
    var body: some View {
        HStack {
            Image(.imgGroup)
                .frame(width: 36, height: 36)
                .padding(.leading, 16)
            
            Text(groupName)
                .fontWithLineHeight(fontLevel: .heading4)
                .padding(.leading, 10)
            
            Spacer()
            
            Button(action: {
                print("그룹 변경 버튼 탭함")
            }) {
                Image(.icChange)
                    .frame(width: 32, height: 32)
                    .padding(.trailing, 16)
            }
        }
    }
}

#Preview {
    FeedHeaderView()
}
