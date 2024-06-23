//
//  PreviewCreatedTreehouseView.swift
//  Treehouse
//
//  Created by 윤영서 on 6/21/24.
//

import SwiftUI

struct PreviewCreatedTreehouseView: View {
    
    // MARK: - State Property
    
    @State var treehouseName: String = "groupname"
    @State var treehallName: String = "강남팟 새벽 수다ㅋ,ㅋ"
    @State var treehallParticipantsCount: Int = 5
    
    // MARK: - View
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 22) {
                ProgressView(value: 0.66)
                    .tint(.treeGreen)
                    .padding(.bottom, 14)
                    .padding(.top, 14)
                
                Text(StringLiterals.CreateTreehouse.createTreehouseTitle3)
                    .fontWithLineHeight(fontLevel: .heading1)
                    .foregroundStyle(.treeBlack)
                    .padding(.leading, 8)
                    .padding(.bottom, 33)
                
                ZStack {
                    HStack(spacing: 10) {
                        Image(.imgUser)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 36, height: 36)
                        
                        Text(treehouseName)
                            .fontWithLineHeight(fontLevel: .heading4)
                            .foregroundStyle(.treeBlack)
                    }
                    .padding(.bottom, 200)
                    .padding(.trailing, 130)
                    
                    Image(.imgCreatetreehouse)
                    
                    TreeHallView(groupName: treehouseName,
                                 subject: treehallName,
                                 personnel: treehallParticipantsCount)
                        .padding(.bottom, 30)
                }
                
                Spacer()
                
                VStack(spacing: 12) {
                    Button(action: {
                        // TODO: - 다음 뷰로 연결
                    }) {
                        Text("좋아요!")
                            .font(.fontGuide(.body2))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .foregroundStyle(.grayscaleWhite)
                            .background(.grayscaleBlack)
                            .cornerRadius(10)
                            .padding(.trailing, 1)
                    }
                    
                    Button(action: {
                        // TODO: - 이전 뷰로 연결
                    }) {
                        Text("다시 작성하고 싶어요")
                            .font(.fontGuide(.body2))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .foregroundStyle(.gray5)
                            .background(.grayscaleWhite)
                            .cornerRadius(10)
                            .padding(.trailing, 1)
                    }
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 16)
            
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        // TODO: - 뒤로 가기 액션
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.treeBlack)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("트리하우스 만들기")
                        .font(.fontGuide(.body2))
                        .foregroundStyle(.treeBlack)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    PreviewCreatedTreehouseView()
}
